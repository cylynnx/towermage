extends Node2D

func _ready():
	var cards = Globals.enemy.hand.drop_cards(3)
	var x = -235
	for card in cards:
		card.position = Vector2(x, 50)
		$CardsOnScreen.add_child(card)
		x += 240
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.4, 1.4), 0.4)

func _on_quit_pressed():
	get_tree().quit()
