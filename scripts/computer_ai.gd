extends Node2D

class_name AI

var ai_type: String
var card_deck: Array[String]

func pull_card():
	pass
	
func initAI(enemy_type: String):
	ai_type = enemy_type
	
func play_turn():
	pass
