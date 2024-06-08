class_name Player
extends Node2D

# 0 is for human player n > 0 is for computer enemy for now
var player_id: int

# Stuff for debuggin
#TODO: Delete these when not needed
var debug_name: String = ""
#----------------------------------
	
var tower_offset: BuildingOffset
var wall_offset: BuildingOffset

# This class helps draw wall and tower in slices
class BuildingOffset:
	var x: float = 0.0
	var y: float = 0.0
	func _init(_x, _o):
		self.x = _x
		self.y = _o

var tower: int = 20:
	set(n):
		tower = clamp(n, 0, 100)

var wall: int = 5:
	set(n):
		wall = clamp(n, 0, 50)
		
var mine: int = 2
var magic: int = 2
var food: int = 2

var resources: int = 5:
	set(n):
		resources = clamp(n, 0, 999)
		
var mana: int = 5:
	set(n):
		mana = clamp(n, 0, 999)
		
var creatures: int = 5:
	set(n):
		creatures = clamp(n, 0, 999)

var playing_a_discard: bool = false

func _ready():
	if player_id:
		$TowerTop.texture = load("res://assets/WallTower/RedSlices/Top.png")
		tower_offset = BuildingOffset.new(1540, 0)
		wall_offset = BuildingOffset.new(1440, 0)
		$Wall.modulate = Color(0.991, 0.513, 0.544)
		$WallTop.modulate = Color(0.991, 0.513, 0.544)
		$Stats/Tower.position = Vector2(1500, 850)
		$Stats/Wall.position = Vector2(1400, 850)
		$Stats/Mine.position = Vector2(1450, 100)
		$Stats/Magic.position = Vector2(1450, 120)
		$Stats/Food.position = Vector2(1450, 140)
		$Bottom.texture = load("res://assets/WallTower/RedSlices/bottom.png")
		$Bottom.position = Vector2(1540, 810)
	else:
		$TowerTop.texture = load("res://assets/WallTower/BlueSlices/Top.png")
		tower_offset = BuildingOffset.new(70, 0)
		wall_offset = BuildingOffset.new(170, 0)
		$Wall.modulate = Color(0.578, 0.667, 1)
		$WallTop.modulate = Color(0.578, 0.667, 1)
		$Stats/Tower.position = Vector2(20, 850)
		$Stats/Wall.position = Vector2(135, 850)
		$Stats/Mine.position = Vector2(10, 100)
		$Stats/Magic.position = Vector2(10, 120)
		$Stats/Food.position = Vector2(10, 140)
		$Bottom.texture = load("res://assets/WallTower/BlueSlices/Bottom.png")
		$Bottom.position = Vector2(70, 809)
