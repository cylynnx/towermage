extends Node2D

var level_scene: PackedScene = preload("res://scenes/old/level.tscn")
var human_player_scene: PackedScene = preload("res://scenes/old/human_player.tscn")
var computer_player_scene: PackedScene = preload("res://scenes/old/computer_player.tscn")
var level = null

func _on_new_game_pressed():
	var player: Player = human_player_scene.instantiate() as Player
	var enemy: Player = computer_player_scene.instantiate() as Player
	enemy.set_ai(Globals.enemy_list[Globals.enemy_selector])
	level = level_scene.instantiate()
	level.set_players(player, enemy)
	get_tree().root.add_child(level)
	queue_free()
