extends Node2D

var wall_textures: Array[String] = [
	"res://assets/wall/p1.png",
	"res://assets/wall/p2.png",
	"res://assets/wall/p3.png",
	"res://assets/wall/p4.png",
	"res://assets/wall/p5.png",
	"res://assets/wall/p6.png",
	"res://assets/wall/p7.png",
	"res://assets/wall/p8.png",
	"res://assets/wall/p9.png",
	"res://assets/wall/p10.png",
	"res://assets/wall/p11.png",
	"res://assets/wall/p12.png",
]

func _ready():
	$Texture.scale = Vector2(0.15, 0.25)
	$Texture.texture = load(wall_textures.pick_random())
