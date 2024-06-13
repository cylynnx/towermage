class_name Player
extends Node2D

var deck_scene: PackedScene = preload("res://scenes/deck.tscn")
var deck: Deck = null
var hand: Array[Card] = []
# This class helps draw wall and tower in slices. May change later.
class BuildingOffset:
	var x: float = 0.0
	var y: float = 0.0
	func _init(_x, _o):
		self.x = _x
		self.y = _o

var tower_offset: BuildingOffset
var wall_offset: BuildingOffset

# ----------------------Buildings-And-Resources---------------------------------
var tower: int = 20:
	set(n):
		tower = clamp(n, 0, 50)

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
#-------------------------------------------------------------------------------

var playing_a_discard: bool = false

func init_deck():
	deck = deck_scene.instantiate() as Deck
	print("inside deck")
