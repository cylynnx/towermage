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
		
func _process(_delta):
	if send_card_off_screen:
		_send_card_off_screen(_card)
		send_card_off_screen = false
		
func _send_card_off_screen(card: Card) -> void:
	if not is_instance_valid(card) or card == null:
		return
		
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(card, "position", Vector2(-1100, -700,), 0.8)
	tween.tween_property(card, "scale", Vector2(0.1, 0.1), 0.8)
	tween.tween_property(card, "modulate", Color(1, 1, 1, 0), 1.5)
	$Buttons/Next.visible = true
	
func _on_suspend_card_timer_timeout():
	send_card_off_screen = true

func _on_next_pressed():
	get_tree().root.get_child(1).queue_free()
	get_tree().root.get_child(1).remove_child(Globals.player)
	var level_scene: PackedScene = preload("res://scenes/level.tscn")
	var level = level_scene.instantiate()
	var enemy_scene: PackedScene = preload("res://scenes/computer_player.tscn")
	var enemy = enemy_scene.instantiate() as Player
	Globals.enemy_selector += 1
	if Globals.enemy_selector > 2:
		Globals.enemy_selector = 2
	enemy.set_ai(Globals.enemy_list[Globals.enemy_selector])
	level.set_players(Globals.player, enemy)
	Globals.player.hand.add_card_from_drop($CardsOnScreen.get_child(0))
	Globals.player.hand.reset_hand()
	get_tree().root.add_child(level)
	queue_free()
