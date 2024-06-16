extends Player
class_name ComputerPlayer

var packed_ai: PackedScene = preload("res://scenes/computer_ai.tscn")
var ai: AI = null
var hand: Hand

func play_card() -> Card:
	var _card = hand.get_random_card_from_hand()
	if _card.play(self, Globals.current_enemy):
		hand.delete_from_hand(_card.card_order)
		hand.update_hand()
		return _card
	return null
	
func _ready():
	ai = packed_ai.instantiate() as AI
	ai.init_ai("Goblin Lord")
	hand = Hand.new(5, deck, ai.cards)
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
	$Portrait.texture = load("res://assets/Portraits/Goblin.png")
	$Portrait.position = Vector2(1540, 48)
