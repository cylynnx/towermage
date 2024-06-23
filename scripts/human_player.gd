extends Player
class_name HumanPlayer

var starting_deck: Array[String] = [
	"Portcullis", "Crystal Matrix", "Gemstone Flaw", "Reinforced Wall",
	"Rabbid Sheep", "Slasher", "Friendly Terrain", "Foundation", "Sturdy Wall", "Big Wall",
	"Miner", "Big Wall", "Stone Giant", "Smoky Quartz", "Ruby", "Emerald", "Werewolf", "Dwarf",
	"Harmonic Ore", "Tower Gremlin"
	
]
var hand = Hand.new(5, deck, starting_deck)

func _ready():
	tower = 1
	
	$TowerTop.texture = load("res://assets/WallTower/BlueSlices/Top.png")
	tower_offset = BuildingOffset.new(70, 0)
	wall_offset = BuildingOffset.new(170, 0)
	$Wall.modulate = Color(0.578, 0.667, 1)
	$WallTop.modulate = Color(0.578, 0.667, 1)
	$Stats/Tower.position = Vector2(20, 850)
	$Stats/Wall.position = Vector2(135, 850)
	$Stats/Mine.position = Vector2(10, 100)
	$Stats/Magic.position = Vector2(10, 125)
	$Stats/Food.position = Vector2(10, 150)
	$Bottom.texture = load("res://assets/WallTower/BlueSlices/Bottom.png")
	$Bottom.position = Vector2(70, 809)
	$Portrait.texture = load("res://assets/Portraits/Sorceress.png")
