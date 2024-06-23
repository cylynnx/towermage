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
		"Dark Knight":
			cards = [
				"Husbandry", "Miner", "Slasher", "Pearl of Wisdom", "Tower Gremlin", "Dwarven Miners",
				"Big Wall", "Reinforced Wall", "Castle Wall", "Spell Weavers", "Vampire", "Succubus", 
				"Portcullis", "Crystal Matrix", "Harmonic Vibe", "Discord", "Crumblestone", "Gemstone Flaw",
				"Solar Flare", "Gem Spear", "Fire Ruby", "Rock Stomper", "Little Snakes", "Orc",
				"Elven Archer"
			]
		"Dragon Mage":
			cards = [
				"Gem Spear", "Fire Ruby", "Rock Stomper", "Little Snakes", "Tower Gremlin", "Spell Weavers",
				"Unicorn", "Dragon's Eye", "Dragon's Heart", "Dragon", "Lava Jewel", "Pearl of Wisdom", 
				"Crystal Matrix", "Harmonic Vibe", "Slasher", "Vampire", "Gemstone Flaw", "Sapphire", 
				"Diamond"
			]
	
