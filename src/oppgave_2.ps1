# Oppgave 2

param (
    [Parameter()]
    [String]
    $Navn = "Silje",
    $Lokasjon = "Gan"
)

Write-Host "Hei $Navn fra $Lokasjon!"