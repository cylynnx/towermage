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

func show_discarded_label() -> void:
	$DiscardedLabel.visible = true
	
func show_discard_this_card_label() -> void:
	$DiscardThisCardLabel.visible = true

func hide_discard_this_card_label() -> void:
	$DiscardThisCardLabel.visible = false

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

func get_cost_string() -> String:
	if resource_cost:
		return str(resource_cost)
	elif mana_cost:
		return str(mana_cost)
	elif creature_cost:
		return str(creature_cost)
	return "Free"
	
func get_resource_type_string() -> String:
	if resource_cost:
		return "resources"
	elif mana_cost:
		return "mana"
	elif creature_cost:
		return "creatures"
	return "Free"
	
func play_resource_warning_sound() -> void:
	match get_resource_type_string():
		"resources":
			$Sound/NoResources.play()
		"mana":
			$Sound/NoMana.play()
		"creatures":
			$Sound/NoCreatures.play()
	
func get_resource_type_color() -> Color:
	if resource_cost:
		return Color(0.853, 0.344, 0)
	elif mana_cost:
		return Color(0.137, 0.447, 0.78)
	elif creature_cost:
		return Color(0.89, 0.58, 0.878)
	return Color(0,0,0,0)

func pay_for_card(player: Player) -> void:
	player.resources -= resource_cost
	player.mana -= mana_cost
	player.creatures -= creature_cost
	
func end_turn() -> void:
	Globals.turn_ended = true
	
func continue_turn(player: Player, playing_discard: bool = false) -> void:
	# TODO: change this
	player.playing_a_discard = playing_discard
	
func play(player: Player, enemy: Player) -> bool:
	match card_name:
		"Agriculture":
			if can_afford_card(player):
				pay_for_card(player)
				player.food += 2
				end_turn()
				return true
		"Husbandry":
			if can_afford_card(player):
				pay_for_card(player)
				player.food += 1
				end_turn()
				return true
				
		"Brick Shortage":
			if can_afford_card(player):
				pay_for_card(player)
				player.resources -= 8
				enemy.resources -= 8
				end_turn()
				return true
		"Full Moon":
			if can_afford_card(player):
				pay_for_card(player)
				player.food += 1
				player.creatures += 3
				end_turn()
				return true
		"Portcullis":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 5
				player.food += 1
				end_turn()
				return true
		"New Equipment":
			if can_afford_card(player):
				pay_for_card(player)
				player.mine += 2
				end_turn()
				return true
		"Fairy":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 2)
				continue_turn(player) # Play again card.
				return true
		"Shadow Fairy":
			if can_afford_card(player):
				pay_for_card(player)
				enemy.tower -= 2
				continue_turn(player)
				return true
		"Elven Scout":
			if can_afford_card(player):
				pay_for_card(player)
				Globals.discard_flag = true # Discard 1 card
				continue_turn(player, true) # End turn after discard
				return true
		"Goblin Archers":
			if can_afford_card(player):
				pay_for_card(player)
				enemy.tower -= 3
				damage(player, 1)
				end_turn()
				return true
		"Moody Goblins":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 4)
				player.mana -= 3
				end_turn()
				return true
		"Goblin Mob":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 6)
				damage(player, 3)
				end_turn()
				return true
		"Rabbid Sheep":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 6)
				enemy.creatures -= 3
				end_turn()
				return true
		"Orc":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 5)
				end_turn()
				return true
		"Slasher":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 6)
				end_turn()
				return true
		"Ogre" :
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 7)
				end_turn()
				return true
		"Werewolf":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 9)
				end_turn()
				return true
		"Elven Archer":
			if can_afford_card(player):
				pay_for_card(player)
				if player.wall > enemy.wall:
					enemy.tower -= 7
				else:
					damage(enemy, 7)
				end_turn()
				return true
		"Imp":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 6)
				player.resources -= 5
				player.mana -= 5
				player.creatures -= 5
				enemy.resources -= 5
				enemy.mana -= 5
				enemy.creatures -= 5
				end_turn()
				return true
		"Dwarf":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 4)
				player.wall += 3
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
		"Corrosive Cloud":
			if can_afford_card(player):
				pay_for_card(player)
				if enemy.wall > 0:
					damage(enemy, 10)
				else:
					damage(enemy, 7)
				end_turn()
				return true
		"Work Overtime":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 5
				player.mana -= 6
				end_turn()
				return true
		"Crystal Rocks":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 7
				player.mana += 7
				end_turn()
				return true
		"Harmonic Ore":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 6
				player.tower += 3
				end_turn()
				return true
		"Friendly Terrain":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 1
				continue_turn(player)
				return true
		"Foundation":
			if can_afford_card(player):
				pay_for_card(player)
				if player.wall <= 0:
					player.wall += 6
				else:
					player.wall += 3
				end_turn()
				return true
		"Forced Labor":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 9
				player.creatures -= 5
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
		"Stone Giant":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 10)
				player.wall += 4
				end_turn()
				return true
		"Dwarven Miners":
			if can_afford_card(player):
				pay_for_card(player)
				player.mine += 1
				player.wall += 4
				end_turn()
				return true
		"Miner":
			if can_afford_card(player):
				pay_for_card(player)
				player.mine += 1
				end_turn()
				return true
		"Crystal Shield":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 8
				player.wall += 3
				end_turn()
				return true
		"Focused Designs":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 8
				player.tower += 5
				end_turn()
				return true
		"Strip Mine":
			if can_afford_card(player):
				pay_for_card(player)
				player.mine -= 1
				player.wall += 10
				player.mana  += 5
				end_turn()
				return true
		"Coppin' the Tech":
			if can_afford_card(player):
				pay_for_card(player)
				var max_mine = max(player.mine, enemy.mine)
				player.mine = max_mine
				enemy.mine = max_mine
				end_turn()
				return true
		"Quarry's Help":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 7
				player.resources -= 10
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
		"Parity":
			if can_afford_card(player):
				pay_for_card(player)
				var max_magic = max(player.magic, enemy.magic)
				player.magic = max_magic
				enemy.magic = max_magic
				end_turn()
				return true
		"Spell Thief":
			if can_afford_card(player):
				pay_for_card(player)
				enemy.tower -= 1
				enemy.mana -= 10
				enemy.resources -= 5
				player.mana += 5
				player.resources += 3
				end_turn()
				return true
		"Rock Thrower":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall += 6
				damage(enemy, 10)
				end_turn()
				return true
		"Rock Stomper":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 8)
				enemy.mine -= 1
				end_turn()
				return true
		"Tower Gremlin":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 2)
				player.wall += 4
				player.tower += 2
				end_turn()
				return true
		"Little Snakes":
			if can_afford_card(player):
				pay_for_card(player)
				enemy.tower -= 4
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
		"Crumblestone":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 5
				enemy.resources -= 6
				end_turn()
				return true
		"Gem Spear":
			if can_afford_card(player):
				pay_for_card(player)
				enemy.tower -= 4
				end_turn()
				return true
		"Lucky Cache":
			if can_afford_card(player):
				pay_for_card(player)
				player.mana += 2
				player.resources += 2
				continue_turn(player)
				return true
		"Pearl of Wisdom":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 4
				player.magic += 1
				end_turn()
				return true
		"Harmonic Vibe":
			if can_afford_card(player):
				pay_for_card(player)
				player.magic += 1
				player.tower += 3
				player.wall += 3
				end_turn()
				return true
		"Crystal Matrix":
			if can_afford_card(player):
				pay_for_card(player)
				player.magic += 1
				player.tower += 1
				enemy.tower += 1
				end_turn()
				return true
		"Power Burn":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower -= 10
				player.magic += 2
				end_turn()
				return true
		"Solar Flare":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 2
				enemy.tower -= 2
				end_turn()
				return true
		"Sanctuary":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 10
				player.wall += 5
				player.creatures += 5
				end_turn()
				return true
		"Prism":
			if can_afford_card(player):
				pay_for_card(player)
				Globals.discard_flag = true
				continue_turn(player)
				return true
		"Empathy Gem":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 8
				player.food += 1
				end_turn()
				return true
		"Dragon's Eye":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 20
				end_turn()
				return true
		"Diamond":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 15
				end_turn()
				return true
		"Sapphire":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 10
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
		"Amethyst":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 3
				end_turn()
				return true
		"Quartz":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 1
				continue_turn(player)
				return true
		"Secret Room":
			if can_afford_card(player):
				pay_for_card(player)
				player.magic += 1
				continue_turn(player)
				return true
		"Gemstone Flaw":
			if can_afford_card(player):
				pay_for_card(player)
				enemy.tower -= 3
				end_turn()
				return true
		"Shatterer":
			if can_afford_card(player):
				pay_for_card(player)
				player.magic -= 1
				enemy.tower -= 9
				end_turn()
				return true
		"Mad Cow Disease":
			if can_afford_card(player):
				pay_for_card(player)
				player.creatures -= 8
				enemy.creatures -= 8
				end_turn()
				return true
		"Discord":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower -= 7
				player.magic -= 1
				enemy.tower -= 7
				enemy.magic -= 1
				end_turn()
				return true
		"Tremors":
			if can_afford_card(player):
				pay_for_card(player)
				player.wall -= 5
				enemy.wall -= 5
				continue_turn(player)
				return true
		"Lava Jewel":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 12
				damage(enemy, 6)
				end_turn()
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
		"Spell Weavers":
			if can_afford_card(player):
				pay_for_card(player)
				player.magic += 1
				end_turn()
				return true
		"Unicorn":
			if can_afford_card(player):
				pay_for_card(player)
				if player.magic > enemy.magic:
					damage(enemy, 12)
				else:
					damage(enemy, 8)
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
		"Crystalize":
			if can_afford_card(player):
				pay_for_card(player)
				player.tower += 11
				player.wall -= 8
				end_turn()
				return true
		"Dragon":
			if can_afford_card(player):
				pay_for_card(player)
				damage(enemy, 20)
				enemy.mana -= 10
				enemy.food -= 1
				end_turn()
				return true
		_:
			return false
	return false

func _on_area_2d_mouse_entered():
	if Globals.discard_flag:
		show_discard_this_card_label()
		
	Globals.current_card = self
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1,1.1), 0.3)
	$Sound/CardSelected.playing = true
	
func _on_area_2d_mouse_exited():
	if Globals.discard_flag:
		hide_discard_this_card_label()
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3)
	$Sound/CardSelected.stop()
	Globals.current_card = null
