class_name Game extends Node2D

func _ready():
	var card: BaseCard = Cards.Agriculture.instantiate() as BaseCard
	card.position = Vector2(200.0, 300.0)
	add_child(card)
