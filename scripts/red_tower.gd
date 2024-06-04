extends Node2D

var tower_textures: Array[String] = [
	"res://assets/WallTower/RedSlices/Slice001.png",
	"res://assets/WallTower/RedSlices/Slice002.png",
	"res://assets/WallTower/RedSlices/Slice003.png",
	"res://assets/WallTower/RedSlices/Slice004.png",
	"res://assets/WallTower/RedSlices/Slice005.png",
	"res://assets/WallTower/RedSlices/Slice006.png",
	"res://assets/WallTower/RedSlices/Slice007.png",
	"res://assets/WallTower/RedSlices/Slice008.png",
	"res://assets/WallTower/RedSlices/Slice009.png",
	"res://assets/WallTower/RedSlices/Slice010.png",
	"res://assets/WallTower/RedSlices/Slice011.png",
	"res://assets/WallTower/RedSlices/Slice012.png",
	"res://assets/WallTower/RedSlices/Slice013.png",
	"res://assets/WallTower/RedSlices/Slice014.png",
	"res://assets/WallTower/RedSlices/Slice015.png"
	]
	
func _ready():
	$Texture.scale = Vector2(0.30, 0.35)
	$Texture.texture = load(tower_textures.pick_random())
