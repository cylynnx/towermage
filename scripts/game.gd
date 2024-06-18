extends Node2D

const MAX_BUILDING_HEIGHT = 50
const CARD_OFFSET_X  = 235
const CARD_X_CONST = 340
const CARD_Y_CONST = 730
const TOWER_Y_CONST = 800
const OFFSET_Y = 6
const TOWER_TOP = 0
const WALL_TOP = 1
const TOWER = 2
const WALL = 3
const HALF_DARK = Color(0.5, 0.5, 0.5, 0.9)
const FULL_BRIGHT = Color(1, 1, 1, 1)
# Game Settings
@export var settings_particles: bool = false
@export var tower_win_condition: int = 50
# ----------------------------------
var deck_scene: PackedScene = preload("res://scenes/deck.tscn")
var blue_tower_scene: PackedScene = preload("res://scenes/blue_tower.tscn")
var red_tower_scene: PackedScene = preload("res://scenes/red_tower.tscn")
var wall_scene: PackedScene = preload("res://scenes/wall.tscn")
var human_player_scene: PackedScene = preload("res://scenes/human_player.tscn")
var computer_player_scene: PackedScene = preload("res://scenes/computer_player.tscn")
var card_drop_scene: PackedScene = preload("res://scenes/card_drop.tscn")

signal GameOver(winner)

var player: Player = null
var computer: Player = null

var deck: Deck = null
var computer_deck: Deck = null
var new_slice: Node2D = null

var enemy_card_on_screen: bool = false
var fade_out_card: bool = false
var clean_up_card: bool = false
var turn_pause_timer_ended: bool = true
var game_over: bool = false

func _ready():
	fade_in_scene()	
	init_players()
	draw_player_hand_on_screen()
	draw_buildings([player, computer])
	update_player_ui([player, computer])
	
func fade_in_scene():
	modulate = Color(0.3, 0.3, 0.2, 1)
	var init_tween = create_tween()
	init_tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.5)

func init_players():
	player = human_player_scene.instantiate() as HumanPlayer
	add_child(player)
	
	computer = computer_player_scene.instantiate() as ComputerPlayer
	add_child(computer)
	
	Globals.current_player = player
	Globals.current_enemy = computer

func draw_player_hand_on_screen():
	for i in player.hand.size():
		draw_card(player.hand.get_card(i))

func draw_buildings(players: Array[Player]) -> void:
	var _tower_scene = null
	for _player in players:
		if _player is ComputerPlayer:
			_tower_scene = red_tower_scene
		else:
			_tower_scene = blue_tower_scene
		init_building(_player.get_child(TOWER), _tower_scene, _player.tower_offset, _player.get_child(TOWER_TOP), 32, _player.tower)
		init_building(_player.get_child(WALL), wall_scene, _player.wall_offset, _player.get_child(WALL_TOP), 5, _player.wall)

func init_building(building: Node2D, scene: PackedScene, offset, top: Node2D, top_offset: float, init_hp: int):
	for i in range(init_hp):
		new_slice = scene.instantiate() as Node2D
		new_slice.position = Vector2(offset.x, 900)
		building.add_child(new_slice)
		var t = create_tween()
		t.tween_property(new_slice, "position", Vector2(offset.x, TOWER_Y_CONST - offset.y), 0.5)
		offset.y += OFFSET_Y
		top.position = Vector2(offset.x, TOWER_Y_CONST - offset.y - top_offset)
		
func update_buildings(players: Array[Player]) -> void:
	var _tower_scene = null
	for _player in players:
		if _player is ComputerPlayer:
			_tower_scene = red_tower_scene
		else:
			_tower_scene = blue_tower_scene
		update_building(_player.get_child(WALL), wall_scene, _player.wall_offset, _player.get_child(WALL_TOP), 5, _player.wall)
		update_building(_player.get_child(TOWER), _tower_scene, _player.tower_offset, _player.get_child(TOWER_TOP), 32, _player.tower)
	
func update_building(building: Node2D, scene: PackedScene, offset, top_piece: Node2D, top_offset: float, hp: int):
	# TODO: refactor this by creating two functions.
	# One for creating a slice and the other for deleting it.
	if offset.y < 0:
		offset.y = 0
		
	var total = building.get_child_count()
	var dif = total - hp
	var slices: Array = building.get_children()

	if dif > 0:
		for i in range(dif):
			var slice: Node2D = slices.pop_back()
			if slice:
				if settings_particles:
					$BuildingCrumbles.position = slice.position
					$BuildingCrumbles.emitting = true
				slice.queue_free()
			offset.y -= OFFSET_Y
		total = building.get_child_count()
		
	if dif < 0:
		for i in range(abs(dif)):
			var _t = create_tween()
			new_slice = scene.instantiate() as Node2D
			new_slice.position = Vector2(offset.x, 700)
			# Visually cap the tower or wall at 50 nodes tall
			if total > MAX_BUILDING_HEIGHT:
				# Unnecessary tween just to shut up the debugger
				_t.tween_property(new_slice, "position", Vector2(offset.x, TOWER_Y_CONST - offset.y), 0.03)
				break
			building.add_child(new_slice)
			_t.tween_property(new_slice, "position", Vector2(offset.x, TOWER_Y_CONST - offset.y), 0.2)
			offset.y += OFFSET_Y
			total += 1
	var t = create_tween()
	t.tween_property(top_piece, "position", Vector2(offset.x, TOWER_Y_CONST - offset.y - top_offset), 0.2) # change 48 to variable
	
func draw_card(card: Card):
	# Place the card off-screen.
	card.global_position = Vector2(800, -300)
	if not is_instance_valid(card) or card == null:
		print("draw_card(card: Card) --- card instance invalid or null!")
		return
	$PlayerCards.add_child(card)
	# Move the card into position.
	var tween = create_tween() 
	tween.tween_property(card, "position", Vector2(CARD_X_CONST + card.card_order * CARD_OFFSET_X, CARD_Y_CONST), 0.4)

#-------Stuff for debugging.TODO: Remove/Refactor later.------------------------
func debug_card(card_name: String):
	draw_custom_card(card_name)

func draw_custom_card(card_name: String):
	var custom_card: Card = deck.create_single_card(card_name)
	custom_card.global_position = Vector2(900, 400)
	add_child(custom_card)
		
func debug_get_card_info(card) -> void:
	if not is_instance_valid(card):
		return
				
	if card:
		var info_string: String = card.card_name
		#debug_text += " Order: " + str(card.card_order)
		info_string += ": " + card.card_description
		$UI/CardInfo.text = info_string
	else:
		$UI/CardInfo.text = ""
#-------------------------------------------------------------------------------
		
func update_resources(players: Array[Player]) -> void:
	for _player in players:
		_player.resources += player.mine
		_player.mana += player.magic
		_player.creatures += player.food

func update_player_ui(players: Array[Player]) -> void:
	for _player in players:
		_player.get_child(4).get_child(0).text = "Tower: " + str(_player.tower)
		_player.get_child(4).get_child(1).text = "Wall: " + str(_player.wall)
		_player.get_child(4).get_child(2).text = "Mine: " + str(_player.mine) + " Resources: " + str(_player.resources)
		_player.get_child(4).get_child(3).text = "Magic: " + str(_player.magic) + " Mana: " + str(_player.mana)
		_player.get_child(4).get_child(4).text = "Food: " + str(_player.food) + " Creatures: " + str(_player.creatures)

func delete_card(card: Card) -> void:
	player.hand.delete_from_hand(card.card_order)
	card.queue_free()
	Globals.current_card = null

func delete_enemy_card() -> void:
	if $EnemyCard.get_child_count():
		$EnemyCard.get_child(0).queue_free()
		
func move_card_to_mid_screen(card: Card) -> void:
	if is_instance_valid(card):
		var t = create_tween()
		t.tween_property(card, "position", Vector2(CARD_X_CONST + 4 * CARD_OFFSET_X, 400), 0.5)
		enemy_card_on_screen = true
		$Timers/FadeOutCardTimer.start()
		
func computer_move() -> void:
	# TODO: Make an actual AI opponent
	var _card: Card = computer.play_card()
	if _card:
		_card.position = Vector2(1600, 500)
		$EnemyCard.add_child(_card)
		move_card_to_mid_screen(_card)
	update_resources([player, computer])
	update_buildings([player, computer])
	update_player_ui([player, computer])
	Globals.turn_ended = true
	if Globals.turn_ended:
		hand_over_turn()
	
func player_move() -> void:
	# Let's make sure you are playing YOUR card.
	if not player.hand.in_hand(Globals.current_card):
		return
	
	if Globals.current_card.play(Globals.current_player, Globals.current_enemy):
		delete_card(Globals.current_card)
		update_player_hand()
		update_buildings([player, computer])
		update_player_ui([player, computer])
		#Globals.turn_ended = true
		if Globals.turn_ended:
			hand_over_turn()
	else:
		Globals.current_card.play_resource_warning_sound()
		
func next_turn():
	if Globals.current_player == player and turn_pause_timer_ended:
		turn_pause_timer_ended = false
		
	elif Globals.current_player == computer and turn_pause_timer_ended:
		delete_enemy_card()
		turn_pause_timer_ended = false
		computer_move()
	else:
		return
		
func update_player_hand():
	for card in $PlayerCards.get_children():
		if not card.is_queued_for_deletion():
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(card, "position", Vector2(CARD_X_CONST + card.card_order * CARD_OFFSET_X, CARD_Y_CONST), 0.4)
	draw_card(player.hand.get_newest_card())

func update_game() -> void:
	if enemy_card_on_screen and fade_out_card:
		if $EnemyCard.get_child_count():
			fade_card($EnemyCard.get_child(0), 1.5)
		enemy_card_on_screen = false
		fade_out_card = false
	message()
	if game_over:
		return
	next_turn()
	check_game_state()

func message() -> void:
	if game_over:
		$UI/Msg.text = "GAME OVER"
		return
		
	if Globals.current_player == player and Globals.discard_flag:
		$UI/Msg.text = "DISCARD CARD!"
	elif Globals.current_player == player:
		$UI/Msg.text = "YOUR TURN!"
	elif Globals.current_player == computer:
		$UI/Msg.text ="ENEMY'S TURN!"
		
func fade_card(card: Card, rate: float) -> void:
	if is_instance_valid(card):
		var t = create_tween()
		t.tween_property(card, "modulate", Color(1, 1, 1, 0), rate)

func modify_hand_color(clr: Color) -> void:
	var t = create_tween()
	t.set_parallel()
	for _card in $PlayerCards.get_children():
		if not _card.is_queued_for_deletion() and is_instance_valid(_card):
			t.tween_property(_card, "modulate", clr, 0.2)
			
func can_play_card() -> bool:
	if game_over:
		return false
		
	if not is_instance_valid(Globals.current_card):
		return false
		
	return Globals.current_card and Globals.current_player == player
	
func discard_card(card: Card) -> void:
	if can_play_card():
		card.hide_discard_this_card_label()
		card.show_discarded_label()
		card.scale = Vector2(1,1)
		var tween = create_tween()
		await tween.tween_property(card, "position", card.position + Vector2(0, 400), 1).finished
		delete_card(card)
		update_player_hand()
	
func _input(event):
	if event.is_action_released("left_click"):
		if Globals.discard_flag:
			# Some cards will ask to discard one card and then the turn ends
			# while other cards will allow to play again after discarding.
			# I'm using player.playing_a_discard bool flag to differentiate
			# between these two scenarios. 
			if player.playing_a_discard:
				discard_card(Globals.current_card)
				Globals.discard_flag = false
				player.playing_a_discard = false
				hand_over_turn()
				return
			else:
				discard_card(Globals.current_card)
				Globals.discard_flag = false
				return
			
		if can_play_card():
			player_move()

	if event.is_action_released("right_click"):
		if Globals.current_card:
			discard_card(Globals.current_card)
			hand_over_turn()
	
	if event.is_action_released("menu"):
		if visible:
			visible = false
			get_tree().root.get_child(1).visible = true
		else:
			visible = true
			get_tree().root.get_child(1).visible = false
			
func hand_over_turn() -> void:
	if Globals.current_player == player:
		Globals.current_player = computer
		Globals.current_enemy = player
		modify_hand_color(HALF_DARK)
		Globals.turn_ended = false
	else:
		Globals.current_player = player
		Globals.current_enemy = computer
		modify_hand_color(FULL_BRIGHT)
		Globals.turn_ended = false
	$Timers/TurnPauseTimer.start()
	
func check_game_state():
	if player.tower <= 0 and computer.tower <= 0:
		emit_signal("GameOver", null)
		return
		
	if player.tower <= 0:
		emit_signal("GameOver", computer)
	elif computer.tower <= 0:
		emit_signal("GameOver", player)
	elif player.tower >= tower_win_condition:
		emit_signal("GameOver", player)
	elif computer.tower >= tower_win_condition:
		emit_signal("GameOver", computer)
		
func _physics_process(_delta):
	debug_get_card_info(Globals.current_card)
	update_game()

func _on_fade_out_card_timer_timeout():
	fade_out_card = true

func _on_turn_pause_timer_timeout():
	turn_pause_timer_ended = true

func _on_game_over(_winner):
	game_over = true
	if _winner == null:
		$UI/Winner.text = "It's a draw!"
		$Audio/YouWin.play()
	elif _winner == computer:
		$UI/Winner.text = "You lose."
		$Audio/YouLose.play()
	else:
		$UI/Winner.text = "You Win!"
		$Audio/YouWin.play()
		
	#$UI/GameOverMsg.text = "Press ESC to exit to main menu."
	$UI/NextButton.visible = true

func _on_texture_button_pressed():
	var card_drop_node = card_drop_scene.instantiate() as Node2D
	get_tree().root.add_child(card_drop_node)
	$UI/NextButton.visible = false
