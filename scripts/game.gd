class_name Game extends Node2D

func _ready():
	var card: BaseCard = Cards.Agriculture.instantiate() as BaseCard
	add_child(card)
