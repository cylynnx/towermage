class_name Card
extends Node2D

var card_name: String = ""
var card_owner: Player = null
var card_description: String = ""
var resource_cost: int = 0
var mana_cost: int = 0
var creature_cost: int = 0
var can_be_discarded: bool = true
var card_order: int = 0

func damage(enemy: Player, dmg: int):
	var dmg_buffer: int = dmg
	if enemy.wall > 0:
		dmg_buffer -= enemy.wall
		enemy.wall = enemy.wall - dmg
		enemy.tower -= max(0, dmg_buffer)
	else:
		enemy.tower -= dmg
		
func can_afford_card(player: Player) -> bool:
		return player.resources >= resource_cost and player.mana >= mana_cost and player.creatures >= creature_cost

func pay_for_card(player: Player) -> void:
	player.resources -= resource_cost
	player.mana -= mana_cost
	player.creatures -= creature_cost
		
func play(player: Player, enemy: Player) -> bool:
	match card_name:
		"Fairy":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 2)
				#Play Again Card
				return true
		"Elven Scout":
			if can_afford_card(player):
				pay_for_card(player)
				Globals.discard_flag = true
				#Play Again Card
				return true
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
