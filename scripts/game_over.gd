class_name GameOver
extends Node2D

func _ready():
	modulate = Color(0.4, 0.3, 0.2, 1)
	var init_tween = create_tween()
	init_tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 1.8)
	
func set_winner(winner):
	if winner.player_id:
		$Control/VBoxContainer/Winner.text = "You lost!"
	else:
		$Control/VBoxContainer/Winner.text = "You won!"
