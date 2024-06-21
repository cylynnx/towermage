extends Node2D

var level_scene: PackedScene = preload("res://scenes/level.tscn")
var level = null

func _on_button_2_button_down():
	get_tree().quit()

func _on_new_game_button_down():
	level = level_scene.instantiate()
	get_tree().root.add_child(level)
	queue_free()
