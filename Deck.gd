class_name Deck
extends Node2D

const CARD_SCENE: PackedScene = preload("res://scenes/card.tscn")

const DECK_SIZE: int = 64

enum {TEXTURE, BOARDER, DESCRIPTION, RESOURCE_COST, MANA_COST, CREATURE_COST, CAN_DISCARD}
	
var card_map: Dictionary = {
	#"Fairy" : [
		#"res://assets/Cards/Fairy/art_fairy.jpg",
		#"res://assets/Borders/Creature_Boarder.png",
		#"2 Damage. Play Again!",
		#0, 0, 1,
		#true
		#],
		
	"Ogre" : [
		"res://assets/Cards/Ogre/art_Ogre.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"7 Damage",
		0, 0, 6,
		true
	],
	
	"Orc" : [
		"res://assets/Cards/Orc/art_Orc.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"5 Damage",
		0, 0, 4,
		true
	],
	
	"Basic Wall" : [
		"res://assets/Cards/Basic Wall/art_BasicWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+3 Wall",
		2, 0, 0,
		true
	],
	
	"Big Wall" : [
		"res://assets/Cards/Big Wall/art_BigWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+6 Wall",
		5, 0, 0,
		true
	],
	
	"Castle Wall" : [
		"res://assets/Cards/Castle Wall/art_CastleWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+12 Wall",
		12, 0, 0,
		true
	]
}

var cards: Array[Card] = []

func create(belongs_to: Player):
	for i in range(DECK_SIZE):
		var card = CARD_SCENE.instantiate() as Card
		var pic = card.get_child(0).get_child(0)
		var boarder = card.get_child(0).get_child(1)
		card.card_name = card_map.keys().pick_random()
		card.card_owner = belongs_to
		pic.scale = Vector2(0.25, 0.25)
		pic.texture = load(card_map[card.card_name][TEXTURE])
		boarder.scale = Vector2(0.28, 0.28)
		boarder.texture = load(card_map[card.card_name][BOARDER])
		card.card_description = card_map[card.card_name][DESCRIPTION]
		card.resource_cost = card_map[card.card_name][RESOURCE_COST]
		card.mana_cost = card_map[card.card_name][MANA_COST]
		card.creature_cost = card_map[card.card_name][CREATURE_COST]
		card.can_be_discarded = card_map[card.card_name][CAN_DISCARD]
		cards.append(card)
