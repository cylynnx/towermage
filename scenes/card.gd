class_name Card
extends Node2D

var card_name: String = ""
var card_owner: Player = null
var card_description: String = ""
var card_order: int = 0

func damage(enemy: Player, dmg: int):
	var dmg_buffer: int = dmg
	if enemy.wall > 0:
		dmg_buffer -= enemy.wall
		enemy.wall = enemy.wall - dmg
		enemy.tower -= max(0, dmg_buffer)
	else:
		enemy.tower -= dmg
	
func play(player: Player, enemy: Player) -> bool:
	match card_name:
		"Dwarf":
			if player.creatures >= 5:
				player.creatures -= 5
				damage(enemy, 4)
				player.wall += 3
				return true
		"Dragon":
			if player.creatures >= 25:
				player.creatures -= 25
				damage(enemy, 20)
				enemy.food -= 1
				enemy.mana -= 10
				return true
		_:
			return false
	return false

func _on_area_2d_mouse_entered():
	Globals.current_card = self
	$Sound/CardSelected.playing = true
	
func _on_area_2d_mouse_exited():
	$Sound/CardSelected.stop()
	Globals.current_card = null
