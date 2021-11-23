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

$kortstokk = @()                                #tom liste
foreach ($card in $cards) {                     #populerer listen med hvert object i $cards
    $kortstokk += ($card.suit[0] + $card.value) #populerer listen med både type og verdi for objectene
}

Write-Host "Kortstokk: $kortstokk"