[CmdLetBinding()] 
param (
    [Parameter()]
    [String]
    $UrlKortstokk = "http://nav-deckofcards.herokuapp.com/shuffle"
    #$UrlKortstokk = "www.noesomikkefinnes.no"
)

$ErrorActionPreference = 'Stop'                 #Stopper scriptet ved første feil

$response = Invoke-WebRequest -Uri $UrlKortstokk

$cards = $response.content | ConvertFrom-Json

# Switch-metode for å populere verdier
$sum = 0
foreach ($card in $cards) {                     
    $sum += switch ($card.value) {
        'J' { 10 }
        'Q' { 10 }
        'K' { 10 }
        'A' { 11 }
        Default { $card.value}
    }
}

# Alternativ IF-metode for samme resultat:
#foreach ($card in $cards) {
#    $sum += if ($card.value -eq 'J') {
#        10
#    }
#    elseif ($card.value -eq 'Q') {
#        10
#    }
#    elseif ($card.value -eq 'K') {
#        10
#    }
#    elseif ($card.value -eq 'A') {
#        11
#    }
#    else {
#        $card.value
#    }
#}

function kortstokkPrint {
    param (
        [Parameter()]
        [Object[]]
        $cards
    )
    # Skriver ut kortstokk
    $kortstokk = @()                                # Tom liste
    foreach ($card in $cards) {                     # Populerer listen med hvert object i $cards
    $kortstokk += ($card.suit[0] + $card.value)     # Populerer listen med både type og verdi for objectene
    }    
    $kortstokk
}

Write-Host "Kortstokk: $(kortstokkPrint($cards))"
Write-Host "Poengsum: $sum"

$meg = $cards[0..1]                                 #Kortstokkens 2 første kort, begynner på 0
$cards = $cards[2..$cards.Length]                   #Kortstokken minus de to første kortene
$magnus = $cards[0..1]
$cards = $cards[2..$cards.Length]

Write-Host "meg: $(kortstokkPrint($meg))"
Write-Host "magnus: $(kortstokkPrint($magnus))"
Write-Host "Kortstokk: $(kortstokkPrint($cards))"
