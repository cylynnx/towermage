extends Node2D

var level_scene: PackedScene = preload("res://scenes/level.tscn")
var human_player_scene: PackedScene = preload("res://scenes/human_player.tscn")
var computer_player_scene: PackedScene = preload("res://scenes/computer_player.tscn")
var level = null

func _on_button_2_button_down():
	get_tree().quit()

func _on_new_game_button_down():
	level = level_scene.instantiate()
	level.set_players(Globals.player, Globals.enemy)
	get_tree().root.add_child(level)
	queue_free()

func init_players():
	Globals.player = human_player_scene.instantiate() as HumanPlayer
	Globals.enemy = computer_player_scene.instantiate() as ComputerPlayer
	
func _ready():
	init_players()
