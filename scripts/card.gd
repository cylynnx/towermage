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
	
func end_turn() -> void:
	Globals.turn_ended = true
	
func continue_turn(player: Player, playing_discard: bool = false) -> void:
	player.playing_a_discard = playing_discard
	
func play(player: Player, enemy: Player) -> bool:
	match card_name:
		"Fairy":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 2)
				continue_turn(player) # Play again card.
				return true
		"Elven Scout":
			if can_afford_card(player):
				pay_for_card(player)
				player.discard_flag = true # Discard 1 card
				continue_turn(player, true) # End turn after discard
				return true
		"Orc":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 5)
				end_turn()
				return true
		"Ogre" :
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 7)
				end_turn()
				return true
		"Spitter Spider":
			if can_afford_card(player):
				pay_for_card(player)
				if enemy.wall > 0:
					damage(enemy, 6)
				else:
					damage(enemy, 10)
				end_turn()
				return true
		"Basic Wall":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 3
				end_turn()
				return true
		"Sturdy Wall":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 4
				end_turn()
				return true
		"Big Wall":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 6
				end_turn()
				return true
		"Reinforced Wall":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 8
				end_turn()
				return true
		"Castle Wall":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 12
				end_turn()
				return true
		"Great Wall":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 15
				end_turn()
				return true
		"Innovations":
			if can_afford_card(player):
				pay_for_card(player)
				player.mine += 1
				player.mana += 4
				enemy.mine += 1
				end_turn()
				return true
		"Fire Ruby":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 6
				enemy.tower -= 4
				end_turn()
				return true
		"Smoky Quartz":
			if can_afford_card(player):
				pay_for_card(player)
				enemy.tower -= 1
				continue_turn(player)
				return true
		"Gem Spear":
			if can_afford_card(player):
				pay_for_card(player)
				enemy.tower -= 4
				end_turn()
				return true
		"Pearl of Wisdom":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 4
				player.magic += 1
				end_turn()
				return true
		"Prism":
			if can_afford_card(player):
				pay_for_card(player)
				player.discard_flag = true
				continue_turn(player)
				return true
		"Diamond":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 15
				end_turn()
				return true
		"Emerald":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 8
				end_turn()
				return true
		"Ruby":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 5
				end_turn()
				return true
		"Quartz":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 1
				continue_turn(player)
				return true
		"Mad Cow Disease":
			if can_afford_card(player):
				pay_for_card(player)
				player.creatures -= 8
				enemy.creatures -= 8
				end_turn()
				return true
		"Tremors":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall -= 5
				enemy.wall -= 5
				continue_turn(player)
				return true
		"Dragon's Heart":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 20
				player.tower += 8
				end_turn()
				return true
		"Earthquake":
			if can_afford_card(player):
				pay_for_card(player)
				player.mine -= 1
				enemy.mine -= 1
				end_turn()
				return true
		"Lodestone":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 3
				end_turn()
				return true
		"Mother Lode":
			if can_afford_card(player):
				pay_for_card(player)
				if player.mine < enemy.mine:
					player.mine += 2
				else:
					player.mine += 1
				end_turn()
				return true
		"Vampire":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 10)
				enemy.creatures -= 5
				enemy.food -= 1
				end_turn()
				return true
		"Succubus":
			if can_afford_card(player):
				pay_for_card(player)
				enemy.tower -= 5
				enemy.creatures -= 8
				end_turn()
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
