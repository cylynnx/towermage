extends Node2D

var tower_textures: Array[String] = [
	"res://assets/test/towerline001.png",
	"res://assets/test/towerline002.png",
	"res://assets/test/towerline003.png"
	]
	
func _ready():
	$Texture.scale = Vector2(0.15, 0.25)
	$Texture.texture = load(tower_textures.pick_random())
