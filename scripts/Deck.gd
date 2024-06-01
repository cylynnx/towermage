class_name Deck
extends Node2D

const CARD_SCENE: PackedScene = preload("res://scenes/card.tscn")

const DECK_SIZE: int = 64

enum {TEXTURE, BOARDER, DESCRIPTION, RESOURCE_COST, MANA_COST, CREATURE_COST, CAN_DISCARD}
	
var card_map: Dictionary = {
	"Fairy" : [
		"res://assets/Cards/Fairy/art_fairy_resized.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"2 Damage. Play Again!",
		0, 0, 1,
		true
		],
		
	"Elven Scout" : [
		"res://assets/Cards/Elven Scout/art_ElvenScout_resized.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"Discard 1 card, Draw 1 card",
		0, 0, 2,
		true
	],
	
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
	
	"Spitter Spider" : [
		"res://assets/Cards/Spitter Spider/art_SpitterSpider.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"If enemy wall = 0, 10 damage. Else 6 damage.",
		0, 0, 8,
		true
	],
	
	"Basic Wall" : [
		"res://assets/Cards/Basic Wall/art_BasicWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+3 Wall",
		2, 0, 0,
		true
	],
	
	"Sturdy Wall" : [
		"res://assets/Cards/Sturdy Wall/art_SturdyWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+4 Wall",
		3, 0, 0,
		true
	],
	
	"Big Wall" : [
		"res://assets/Cards/Big Wall/art_BigWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+6 Wall",
		5, 0, 0,
		true
	],
	
	"Reinforced Wall" : [
		"res://assets/Cards/Reinforced Wall/art_ReinforcedWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+8 Wall",
		7, 0, 0,
		true
	],
	
	"Castle Wall" : [
		"res://assets/Cards/Castle Wall/art_CastleWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+12 Wall",
		12, 0, 0,
		true
	],
	
	"Great Wall" : [
		"res://assets/Cards/Great Wall/art_GreatWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+15 Wall",
		16, 0, 0,
		true
	],
	
	"Innovations" : [
		"res://assets/Cards/Innovations/art_Inovations.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+1 To All player's Mines you gain 4 mana.",
		2, 0, 0,
		true
	],
	
	"Fire Ruby" : [
		"res://assets/Cards/Fire Ruby/art_FireRuby.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+6 Tower. 4 Damage to enemy tower.",
		0, 15, 0,
		true
	],
	
	"Smoky Quartz" : [
		"res://assets/Cards/Smoky Quartz/art_SmokyQuartz.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"1 Damage to enemy tower. Player again!",
		0, 2, 0,
		true
	],
	
	"Gem Spear" : [
		"res://assets/Cards/Gem Spear/art_GemSpear2.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"5 Damage to enemy tower",
		0, 6, 0,
		true
	],
	
	"Pearl of Wisdom" : [
		"res://assets/Cards/Pearl of Wisdom/art_PearlOfWisdom.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+5 Tower, +1 Magic.",
		0, 9, 0,
		true
	],
	
	"Prism" : [
		"res://assets/Cards/Prism/art_Prism.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"Draw 1 card, Discard 1 card. Play Again!",
		0, 2, 0,
		true
	],
	
	"Diamond" : [
		"res://assets/Cards/Diamond/art_Diamond.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+15 Tower",
		0, 16, 0,
		true
	],
	
	"Emerald" : [
		"res://assets/Cards/Emerald/art_Emerald.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+8 Tower",
		0, 6, 0,
		true
	],
	
	"Ruby" : [
		"res://assets/Cards/Ruby/art_Ruby.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+5 Tower",
		0, 3, 0,
		true 
	],
	
	"Quartz" : [
		"res://assets/Cards/Quartz/art_Quartz.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+1 Tower. Play Again!",
		0, 1, 0,
		true
	],
	
	"Mad Cow Disease" : [
		"res://assets/Cards/Mad Cow Disease/art_MadCow.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"All players lose 8 creatures",
		0, 0, 0,
		true
	],
	
	"Tremors" : [
		"res://assets/Cards/Tremors/art_Tremors.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"All Walls take 5 damage. Play Again!",
		7, 0, 0,
		true
	],
	
	"Dragon's Heart" : [
		"res://assets/Cards/Dragon's Heart/art_Dragon'sHeart.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"+20 Wall +8 Tower.",
		0, 0, 24,
		true
	],
	
	"Earthquake" : [
		"res://assets/Cards/Earthquake/art_Earthquake.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"-1 To All player's Mines.",
		0, 0, 0,
		true
	],
	
	"Lodestone" : [
		"res://assets/Cards/Lodestone/art_Lodestone.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+3 Tower. This card cannot be discarded without playing it.",
		0, 5, 0,
		false
	],
	
	"Mother Lode" : [
		"res://assets/Cards/Mother Lode/art_MotherLode.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"If Mine < enemy Mine +2 Mine, else +1 Mine.",
		4, 0, 0,
		true
	],
	
	"Crystalize" : [
		"res://assets/Cards/Crystalize/art_Crystalize.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+11 Tower -6 Wall.",
		0, 8, 0,
		true
	],
	
	"Vampire" : [
		"res://assets/Cards/Vampire/art_Vampire.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"10 Damage, Enemy loses 5 creatures, -1 enemy Food.",
		0, 0, 17,
		true
	],
	
	"Succubus" : [
		"res://assets/Cards/Succubus/art_Succubus.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"5 Damage to Enemy Tower, Enemy loses 8 creatures.",
		0, 0, 14,
		true
	]
	
}

var cards: Array[Card] = []

func get_cost(card: Card) -> String:
	if card.resource_cost:
		return str(card.resource_cost)
	elif card.mana_cost:
		return str(card.mana_cost)
	elif card.creature_cost:
		return str(card.creature_cost)
	return "F"
	
func get_color(card: Card) -> Color:
	if card.resource_cost:
		return Color(0.853, 0.344, 0)
	elif card.mana_cost:
		return Color(0.137, 0.447, 0.78)
	elif card.creature_cost:
		return Color(0.89, 0.58, 0.878)
	return Color(0,0,0,0)
	
func create(belongs_to: Player):
	for i in range(DECK_SIZE):
		var card = CARD_SCENE.instantiate() as Card
		var pic = card.get_child(0).get_child(0)
		var boarder = card.get_child(0).get_child(1)
		var txt = card.get_child(2)
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
		txt.text = get_cost(card)
		if int(txt.text) > 10:
			txt.position -= Vector2(10, 0)
		txt.modulate = get_color(card)
		cards.append(card)
		
func create_single_card(_name: String, _belongs_to: Player) -> Card:
	var card = CARD_SCENE.instantiate() as Card
	var pic = card.get_child(0).get_child(0)
	var boarder = card.get_child(0).get_child(1)
	var txt = card.get_child(2)
	card.card_name = _name
	card.card_owner = _belongs_to
	pic.scale = Vector2(0.25, 0.25)
	pic.texture = load(card_map[card.card_name][TEXTURE])
	boarder.scale = Vector2(0.28, 0.28)
	boarder.texture = load(card_map[card.card_name][BOARDER])
	card.card_description = card_map[card.card_name][DESCRIPTION]
	card.resource_cost = card_map[card.card_name][RESOURCE_COST]
	card.mana_cost = card_map[card.card_name][MANA_COST]
	card.creature_cost = card_map[card.card_name][CREATURE_COST]
	card.can_be_discarded = card_map[card.card_name][CAN_DISCARD]
	txt.text = get_cost(card)
	if int(txt.text) > 10:
		txt.position -= Vector2(10, 0)
	txt.modulate = get_color(card)
	return card
