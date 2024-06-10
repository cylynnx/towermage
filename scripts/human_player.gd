extends Player
class_name HumanPlayer

func _ready():
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
