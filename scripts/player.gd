class_name Player
extends Node2D

# This class helps draw wall and tower in slices. May change later.
class BuildingOffset:
	var x: float = 0.0
	var y: float = 0.0
	func _init(_x, _o):
		self.x = _x
		self.y = _o
		
var deck_scene: PackedScene = preload("res://scenes/deck.tscn")
var deck: Deck = deck_scene.instantiate() as Deck

class Hand:
	var cards_in_hand: Array[Card] = []
	var _deck: Deck = null
	var card_list: Array = []
	func _init(num_of_cards: int, deck: Deck, cards: Array):
		self._deck = deck
		self.card_list = cards
		for i in num_of_cards:
			var _card: Card = self._deck.create_random_card_from_list(self.card_list)
			_card.card_order = i
			cards_in_hand.append(_card)
		
	func _reindex_hand():
		for i in self.cards_in_hand.size():
			cards_in_hand[i].card_order = i
			
	func add_card_from_drop(card: Card):
		if not is_instance_valid(card):
			return
			
		if card.card_name not in card_list:
			card_list.append(card.card_name)
			
	func update_hand():
		if self.cards_in_hand.size() < 5:
			for i in range(5 - self.cards_in_hand.size()):
				cards_in_hand.append(self._deck.create_random_card_from_list(self.card_list))
		_reindex_hand()
	
	func in_hand(_card: Card) -> bool:
		return _card in cards_in_hand
	
	func size() -> int:
		return cards_in_hand.size()
		
	func get_card(card_index: int) -> Card:
		return cards_in_hand[card_index]
		
	func delete_from_hand(card_index: int):
		cards_in_hand.remove_at(card_index)
		self.update_hand()
	
	func get_newest_card() -> Card:
		return cards_in_hand[cards_in_hand.size() - 1]
	
	func drop_cards(n: int) -> Array[Card]:
		var _cards: Array[Card] = []
		for i in range(n):
			_cards.append(self._deck.create_random_card_from_list(self.card_list))
		return _cards
			
	func get_random_card_from_hand() -> Card:
		return cards_in_hand.pick_random()

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

