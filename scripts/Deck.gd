class_name Deck
extends Node2D

const DECK_SIZE: int = 64
enum {TEXTURE, BOARDER, DESCRIPTION, RESOURCE_COST, MANA_COST, CREATURE_COST, CAN_DISCARD}

var card_scene: PackedScene = preload("res://scenes/card.tscn")
var card_map_scene: PackedScene = preload("res://scenes/card_map.tscn")
var cm = card_map_scene.instantiate() as CardMap
var card_map = cm.card_map
		
func create_random_card() -> Card:
	return create_single_card(card_map.keys().pick_random())
	
func create_single_card(_name: String) -> Card:
	var card = card_scene.instantiate() as Card
	var pic = card.get_child(0).get_child(0)
	var boarder = card.get_child(0).get_child(1)
	var txt = card.get_child(2)
	card.card_name = _name
	pic.scale = Vector2(0.25, 0.25)
	pic.texture = load(card_map[card.card_name][TEXTURE])
	boarder.scale = Vector2(0.28, 0.28)
	boarder.texture = load(card_map[card.card_name][BOARDER])
	card.card_description = card_map[card.card_name][DESCRIPTION]
	card.resource_cost = card_map[card.card_name][RESOURCE_COST]
	card.mana_cost = card_map[card.card_name][MANA_COST]
	card.creature_cost = card_map[card.card_name][CREATURE_COST]
	card.can_be_discarded = card_map[card.card_name][CAN_DISCARD]
	txt.text = card.get_cost_string()
	if int(txt.text) >= 10:
		txt.position -= Vector2(10, 0)
	txt.modulate = card.get_resource_type_color()
	return card
