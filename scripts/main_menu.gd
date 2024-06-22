extends Node2D

var level_scene: PackedScene = preload("res://scenes/level.tscn")
var human_player_scene: PackedScene = preload("res://scenes/human_player.tscn")
var computer_player_scene: PackedScene = preload("res://scenes/computer_player.tscn")
var level = null

func _on_new_game_button_down():
	var player: Player = human_player_scene.instantiate() as Player
	var enemy: Player = computer_player_scene.instantiate() as Player
	level = level_scene.instantiate()
	level.set_players(player, enemy)
	get_tree().root.add_child(level)
	queue_free()
