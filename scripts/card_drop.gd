extends Node2D

var send_card_off_screen: bool = false
var _card: Card = null

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
		_card = Globals.current_card
		if _card == null:
			return
		_card.get_child(0).disconnect("mouse_entered", _card._on_area_2d_mouse_entered)
		_card.get_child(0).disconnect("mouse_exited", _card._on_area_2d_mouse_exited)
		for c in $CardsOnScreen.get_children():
			if not c == _card:
				c.queue_free()
		var tween = create_tween()
		tween.tween_property(_card, "position", Vector2(5, 40), 0.3)
		tween.tween_property(_card, "scale", Vector2(1.2, 1.2), 0.4)
		$SuspendCardTimer.start()
		Globals.current_card = null
		
func _process(_delta):
	if send_card_off_screen:
		_send_card_off_screen(_card)
		send_card_off_screen = false
		
func _send_card_off_screen(card: Card) -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(card, "position", Vector2(-1100, -700,), 0.8)
	tween.tween_property(card, "scale", Vector2(0.1, 0.1), 0.8)
	tween.tween_property(card, "modulate", Color(1, 1, 1, 0), 1.5)
	
func _on_quit_pressed():
	get_tree().quit()

func _on_suspend_card_timer_timeout():
	send_card_off_screen = true

func _on_next_pressed():
	print("Next pressed")
	queue_free()
