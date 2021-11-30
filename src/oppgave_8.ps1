param (
    [Parameter()]
    [String]
    #$UrlKortstokk = "https://azure-gvs-test-cases.azurewebsites.net/api/vinnerDraw"
    $UrlKortstokk = "http://nav-deckofcards.herokuapp.com/shuffle"
    #$UrlKortstokk = "www.noesomikkefinnes.no"
)

$ErrorActionPreference = 'Stop'                 #Stopper scriptet ved første feil

$response = Invoke-WebRequest -Uri $UrlKortstokk

$kortstokk = $response.content | ConvertFrom-Json

# $poengkortstokk = 0
function kortsum {
    param (
        [Parameter()]
        [Object[]]
        $kortstokk
    )
    $poengKortstokk = 0
    foreach ($kort in $kortstokk) {                     
        $poengKortstokk += switch ($kort.value) {
        'J' { 10 }
        'Q' { 10 }
        'K' { 10 }
        'A' { 11 }
        Default {$kort.value}
        }
    }
    $poengKortstokk
}


function kortstokkPrint {
    param (
        [Parameter()]
        [Object[]]
        $kortstokk
    )
    # Skriver ut kortstokk
    $kortstokktabell = @()                                   # Tom liste
    foreach ($kort in $kortstokk) {                          # Populerer listen med hvert object i $cards
    $kortstokktabell += ($kort.suit[0] + $kort.value)        # Populerer listen med både type og verdi for objectene
    }    
    $kortstokktabell
}

Write-Host "Kortstokk: $(kortstokkPrint($kortstokk))"
Write-Host "Poengsum: $(kortsum($kortstokk))"


# Oppgave 6

$meg = $kortstokk[0..1]                                 #Kortstokkens 2 første kort, begynner på 0
$kortstokk = $kortstokk[2..$kortstokk.Length]                   #Kortstokken minus de to første kortene
$magnus = $kortstokk[0..1]
$kortstokk = $kortstokk[2..$kortstokk.Length]


Write-Host "meg: $(kortstokkPrint($meg))"
Write-Host "magnus: $(kortstokkPrint($magnus))"
Write-Host "Kortstokk: $(kortstokkPrint($kortstokk))"


# Oppgave 7


function skrivUtResultat {
    param (
        [string]
        $vinner,        
        [object[]]
        $kortStokkMagnus,
        [object[]]
        $kortStokkMeg        
    )
    Write-Output "Vinner: $vinner"
    Write-Output "magnus | $(kortsum -kortstokk $kortStokkMagnus) | $(kortstokkPrint -kortstokk $kortStokkMagnus)"    
    Write-Output "meg    | $(kortsum -kortstokk $kortStokkMeg) | $(kortstokkPrint -kortstokk $kortStokkMeg)"
}

# bruker 'blackjack' som et begrep - er 21

$blackjack = 21

if ( ((kortsum -kortstokk $meg) -eq $blackjack) -and ((kortsum -kortstokk $magnus) -eq $blackjack)) {
    skrivUtResultat -vinner "draw" -kortStokkMagnus $magnus -kortStokkMeg $meg
    exit
}

elseif ((kortsum -kortstokk $meg) -eq $blackjack) {
    skrivUtResultat -vinner "meg" -kortStokkMagnus $magnus -kortStokkMeg $meg
    exit
}
elseif ((kortsum -kortstokk $magnus) -eq $blackjack) {
    skrivUtResultat -vinner "magnus" -kortStokkMagnus $magnus -kortStokkMeg $meg
    exit
}


# Oppgave 8

while ((kortsum -kortstokk $meg) -lt 17) {
    $meg += $kortstokk[0]
    $kortstokk = $kortstokk[1..$kortstokk.Length]
}

if ((kortsum -kortstokk $meg) -gt $blackjack) {
    skrivUtResultat -vinner "magnus" -kortStokkMagnus $magnus -kortStokkMeg $meg
    exit
}
