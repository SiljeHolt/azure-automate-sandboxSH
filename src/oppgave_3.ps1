$Url = "http://nav-deckofcards.herokuapp.com/shuffle"

$response = Invoke-WebRequest -Uri $Url

$cards = $response.content | ConvertFrom-Json

$kortstokk = @()                                #tom liste
foreach ($card in $cards) {                     #populerer listen med hvert object i $cards
    $kortstokk += ($card.suit[0] + $card.value) #populerer listen med både type og verdi for objectene
}

Write-Host "Kortstokk: $kortstokk"