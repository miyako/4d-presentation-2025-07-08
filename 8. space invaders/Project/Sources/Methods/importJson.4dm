//%attributes = {}
var $myJsonFile : 4D.File
var $jsonContent : Text
var $jsonObject : Object
var $spaceInvaders : Collection

ds.spaceInvader.all().drop()
$myJsonFile:=File("/RESOURCES/space_invaders.geojson")
$jsonContent:=$myJsonFile.getText()
$jsonObject:=JSON Parse($jsonContent)
$spaceInvaders:=$jsonObject.features.extract(\
"id"; "identifier"; \
"properties.name"; "name"; \
"geometry.coordinates[0]"; "longitude"; \
"geometry.coordinates[1]"; "latitude")
ds.spaceInvader.fromCollection($spaceInvaders)

