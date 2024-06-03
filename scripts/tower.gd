extends Node2D

var tower_textures: Array[String] = [
	"res://assets/WallTower/BlueSlices/Slice001.png",
	"res://assets/WallTower/BlueSlices/Slice002.png",
	"res://assets/WallTower/BlueSlices/Slice003.png",
	"res://assets/WallTower/BlueSlices/Slice004.png",
	"res://assets/WallTower/BlueSlices/Slice005.png",
	"res://assets/WallTower/BlueSlices/Slice006.png",
	"res://assets/WallTower/BlueSlices/Slice007.png",
	"res://assets/WallTower/BlueSlices/Slice008.png",
	"res://assets/WallTower/BlueSlices/Slice009.png",
	"res://assets/WallTower/BlueSlices/Slice010.png",
	"res://assets/WallTower/BlueSlices/Slice011.png",
	"res://assets/WallTower/BlueSlices/Slice012.png",
	"res://assets/WallTower/BlueSlices/Slice013.png",
	"res://assets/WallTower/BlueSlices/Slice014.png",
	"res://assets/WallTower/BlueSlices/Slice015.png"
	]
	
func _ready():
	$Texture.scale = Vector2(0.30, 0.35)
	$Texture.texture = load(tower_textures.pick_random())
