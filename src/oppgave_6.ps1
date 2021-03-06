param (
    [Parameter()]
    [String]
    $UrlKortstokk = "http://nav-deckofcards.herokuapp.com/shuffle"
    #$UrlKortstokk = "www.noesomikkefinnes.no"
)

$ErrorActionPreference = 'Stop'                 #Stopper scriptet ved første feil

$response = Invoke-WebRequest -Uri $UrlKortstokk

$kortstokk = $response.content | ConvertFrom-Json

$poengkortstokk = 0
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

$meg = $kortstokk[0..1]                                 #Kortstokkens 2 første kort, begynner på 0
$kortstokk = $kortstokk[2..$kortstokk.Length]                   #Kortstokken minus de to første kortene
$magnus = $kortstokk[0..1]
$kortstokk = $kortstokk[2..$kortstokk.Length]


Write-Host "meg: $(kortstokkPrint($meg))"
Write-Host "magnus: $(kortstokkPrint($magnus))"
Write-Host "Kortstokk: $(kortstokkPrint($kortstokk))"
