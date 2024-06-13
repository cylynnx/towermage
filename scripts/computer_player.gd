extends Player
class_name ComputerPlayer

var packed_ai: PackedScene = preload("res://scenes/computer_ai.tscn")
var ai: AI = null

func play_card() -> Card:
	return deck.create_random_card()
	
func _ready():
	ai = packed_ai.instantiate() as AI
	
	$TowerTop.texture = load("res://assets/WallTower/RedSlices/Top.png")
	tower_offset = BuildingOffset.new(1540, 0)
	wall_offset = BuildingOffset.new(1440, 0)
	$Wall.modulate = Color(0.991, 0.513, 0.544)
	$WallTop.modulate = Color(0.991, 0.513, 0.544)
	$Stats/Tower.position = Vector2(1500, 850)
	$Stats/Wall.position = Vector2(1410, 850)
	$Stats/Mine.position = Vector2(1440, 100)
	$Stats/Magic.position = Vector2(1440, 125)
	$Stats/Food.position = Vector2(1440, 150)
	$Bottom.texture = load("res://assets/WallTower/RedSlices/bottom.png")
	$Bottom.position = Vector2(1540, 810)
