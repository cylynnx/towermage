class_name Deck
extends Node2D

const CARD_SCENE: PackedScene = preload("res://scenes/card.tscn")

const DECK_SIZE: int = 64

const TEXTURE = 0
const DESCRIPTION = 1
	
var card_map: Dictionary = {
	"Sorceress" : [
		"res://assets/cut/SorceressCard001_cut.png",
		"Adds 10 to Mana"
		],
	"Dwarf" : [
		"res://assets/cut/DwarfCard001_cut.png",
		"4 Damage +3 Wall Cost: 5 creatures"
		],
	"Dragon" : [
		"res://assets/cut/DragonCard001_cut.png",
		"20 Damage. Enemy loses 10 mana, -1 enemy Zoo. Cost: 25 creatures"
		],
	"Admiral" : [
		"res://assets/cut/AdmiralCard002_cut.png",
		"10 to Beasts and Resources"
		],
	"BattleMage" : [
		"res://assets/cut/BattleMageCard001_cut.png",
		"25 Damage to enemy"
		],
	"DragonKnight" : [
		"res://assets/cut/DragonKnightCard001_cut.png",
		"30 Damage to Enemy"
		],
}

var cards: Array[Card] = []
var belongs_to: Node2D = null

func create():
	for i in range(DECK_SIZE):
		var card = CARD_SCENE.instantiate() as Card
		var sprite = card.get_child(0).get_child(0)
		card.card_name = card_map.keys().pick_random()
		sprite.scale = Vector2(0.25, 0.25)
		sprite.texture = load(card_map[card.card_name][TEXTURE])
		card.card_description = card_map[card.card_name][DESCRIPTION]
		cards.append(card)
