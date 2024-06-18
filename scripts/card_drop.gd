extends Node2D

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.4, 1.4), 0.4)

func _on_quit_pressed():
	get_tree().quit()
