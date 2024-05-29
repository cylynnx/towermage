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

var resources: int = 5
var mana: int = 5
var creatures: int = 5
		
func _ready():
	if player_id:
		tower_offset = BuildingOffset.new(1450, 0)
		wall_offset = BuildingOffset.new(1300, 0)
		$Stats/Tower.position = Vector2(1400, 750)
		$Stats/Wall.position = Vector2(1260, 750)
		$Stats/Mine.position = Vector2(1450, 100)
		$Stats/Magic.position = Vector2(1450, 120)
		$Stats/Food.position = Vector2(1450, 140)
	else:
		tower_offset = BuildingOffset.new(100, 0)
		wall_offset = BuildingOffset.new(250, 0)
		$Stats/Tower.position = Vector2(50, 750)
		$Stats/Wall.position = Vector2(210, 750)
		$Stats/Mine.position = Vector2(10, 100)
		$Stats/Magic.position = Vector2(10, 120)
		$Stats/Food.position = Vector2(10, 140)
		
		
