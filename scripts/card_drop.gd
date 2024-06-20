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
	
func _input(event):
	if event.is_action_pressed("left_click"):
		Globals.player.hand.add_card_from_drop(Globals.current_card)
		var _card = Globals.current_card
		for c in $CardsOnScreen.get_children():
			if not c == _card:
				c.queue_free()
			
		
func _on_quit_pressed():
	get_tree().quit()
