extends Node2D

class_name AI

var ai_type: String
var cards: Array

func init_ai(_ai_type):
	ai_type = _ai_type
	match ai_type:
		"Goblin Lord":
			cards = [
				"Husbandry", "Goblin Archers", "Moody Goblins", "Goblin Mob", "Orc",
				"Imp", "Basic Wall", "Forced Labor"
			]
	
