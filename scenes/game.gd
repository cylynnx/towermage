extends Node2D

const MAX_BUILDING_HEIGHT = 50
const CARD_OFFSET_X  = 225
const CARD_Y_CONST = 730
const PLAYER_CARD_NUM = 4
const TOWER_TOP = 0
const WALL_TOP = 1
const TOWER = 2
const WALL = 3
# Game Settings
@export var settings_particles: bool = false
# ----------------------------------
var deck_scene: PackedScene = preload("res://scenes/deck.tscn")
var tower_scene: PackedScene = preload("res://scenes/tower.tscn")
var wall_scene: PackedScene = preload("res://scenes/wall.tscn")
var player_scene: PackedScene = preload("res://scenes/player.tscn")

var player: Player = null
var enemy: Player = null

var last_card: Node2D = null
var deck: Deck = null
var enemy_deck: Deck = null
var new_slice: Node2D = null
var card_base_x: int = 200
var shift_cards: bool = false
var enemy_card_on_screen: bool = false
var fade_out_card: bool = false
var clean_up_card: bool = false
var turn_pause_timer_ended: bool = false

func _ready():
	init_players()
	deck = create_deck(player)
	enemy_deck = create_deck(enemy)
	init_player_hand()
	init_buildings([player, enemy])
	update_player_ui([player, enemy])

func init_players():
	player = create_player(0)
	enemy = create_player(1)
	Globals.current_player = player
	Globals.current_enemy = enemy
	
func create_player(player_id: int) -> Player:
	var _player = player_scene.instantiate() as Player
	_player.player_id = player_id
	add_child(_player)
	return _player
	
func create_deck(belongs_to: Player) -> Deck:
	var _deck = deck_scene.instantiate() as Deck
	_deck.create(belongs_to)
	return _deck

func init_player_hand():
	for card_order in range(1, PLAYER_CARD_NUM + 1):
		draw_card(card_order)
	Globals.cards_on_screen = PLAYER_CARD_NUM

func init_buildings(players: Array[Player]) -> void:
	for _player in players:
		init_building(_player.get_child(TOWER), tower_scene, _player.tower_offset, _player.get_child(TOWER_TOP), 48, _player.tower)
		init_building(_player.get_child(WALL), wall_scene, _player.wall_offset, _player.get_child(WALL_TOP), 14, _player.wall)

func init_building(building: Node2D, scene: PackedScene, offset, top: Node2D, top_offset: float, init_hp: int):
	for i in range(init_hp):
		new_slice = scene.instantiate() as Node2D
		new_slice.position = Vector2(offset.x, 900)
		building.add_child(new_slice)
		var t = create_tween()
		t.tween_property(new_slice, "position", Vector2(offset.x, 700 - offset.y), 0.5)
		offset.y += 8
		top.position = Vector2(offset.x, 700 - offset.y - top_offset)
		
func update_buildings(players: Array[Player]) -> void:
	for _player in players:
		update_building(_player.get_child(WALL), wall_scene, _player.wall_offset, _player.get_child(WALL_TOP), 14, _player.wall)
		update_building(_player.get_child(TOWER), tower_scene, _player.tower_offset, _player.get_child(TOWER_TOP), 48, _player.tower)
	
func update_building(building: Node2D, scene: PackedScene, offset, top_piece: Node2D, top_offset: float, hp: int):
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
			offset.y -= 8
		total = building.get_child_count()
		
	if dif < 0:
		for i in range(abs(dif)):
			var _t = create_tween()
			new_slice = scene.instantiate() as Node2D
			new_slice.position = Vector2(offset.x, 700)
			# Visually cap the tower or wall at 50 nodes tall
			if total > MAX_BUILDING_HEIGHT:
				# Unnecessary tween just to shut up the debugger
				_t.tween_property(new_slice, "position", Vector2(offset.x, 700 - offset.y), 0.03)
				break
			building.add_child(new_slice)
			_t.tween_property(new_slice, "position", Vector2(offset.x, 700 - offset.y), 0.2)
			offset.y += 8
			total += 1
	var t = create_tween()
	t.tween_property(top_piece, "position", Vector2(offset.x, 700 - offset.y - top_offset), 0.2) # change 48 to variable
	
func draw_card(order: int) -> Card:
	var new_card: Card = deck.cards.pop_back()
	if not new_card:
		return null
	new_card.card_order = order
	new_card.global_position = Vector2(800, -300) # Place card kinda offscreen
	var tween = create_tween() 
	$PlayerCards.add_child(new_card)
	# Move the card into position
	tween.tween_property(new_card, "position", Vector2(card_base_x + order * CARD_OFFSET_X, CARD_Y_CONST), 0.4)
	return new_card
		
func debug_get_card_info(card: Card) -> void:
	$UI/Debug.text = "turn_pause_timer_ended: " + str(turn_pause_timer_ended)
	#$UI/Debug.text += " dif: " + str(dif)
	#$UI/Debug.text += " Offset: " + str(tower_offset)
	$UI/MousePos.text = str(get_global_mouse_position())
	if card:
		var debug_text: String = card.card_name
		#debug_text += " Order: " + str(card.card_order)
		debug_text += card.card_description
		$UI/RichTextLabel.text = debug_text
	else:
		$UI/RichTextLabel.text = ""
		
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
	card.queue_free()
	Globals.current_card = null
	Globals.cards_on_screen -= 1
	shift_cards = true

func delete_enemy_card() -> void:
	if $EnemyCard.get_child_count():
		$EnemyCard.get_child(0).queue_free()
		
func move_card_to_mid_screen(card: Card) -> void:
		var t = create_tween()
		t.tween_property(card, "position", Vector2(800, 400), 0.5)
		enemy_card_on_screen = true
		$Timers/FadeOutCardTimer.start()
		
func ai_move() -> void:
	var _card: Card = enemy_deck.cards.pop_back()
	if not _card:
		return
	if _card.play(Globals.current_player, Globals.current_enemy):
		_card.position = Vector2(1600, 500)
		$EnemyCard.add_child(_card)
		move_card_to_mid_screen(_card)
	update_resources([player, enemy])
	update_buildings([player, enemy])
	update_player_ui([player, enemy])
	Globals.turn_ended = true
	if Globals.turn_ended:
		hand_over_turn()
	
func player_move() -> void:
	if Globals.current_card.play(Globals.current_player, Globals.current_enemy):
		delete_card(Globals.current_card)
		update_player_hand()
		update_buildings([player, enemy])
		update_player_ui([player, enemy])
		Globals.turn_ended = true
		if Globals.turn_ended:
			hand_over_turn()
		
func next_turn():
	if Globals.current_player == player and turn_pause_timer_ended:
		Globals.turn_ended = false
		turn_pause_timer_ended = false
		
	elif Globals.current_player == enemy and turn_pause_timer_ended:
		delete_enemy_card()
		Globals.turn_ended = false
		turn_pause_timer_ended = false
		ai_move()
	else:
		return
		
func update_player_hand():
	if shift_cards:
		var i = 1
		for card in $PlayerCards.get_children():
			if not card.is_queued_for_deletion():
				card.card_order = i
				i += 1
		for card in $PlayerCards.get_children():
			if not card.is_queued_for_deletion():
				var tween = create_tween()
				tween.set_parallel(true)
				tween.tween_property(card, "position", Vector2(card_base_x + card.card_order * CARD_OFFSET_X, CARD_Y_CONST), 0.4)
		shift_cards = false
		
	if Globals.cards_on_screen < PLAYER_CARD_NUM:
		draw_card(4)
		Globals.cards_on_screen += 1

func update_game() -> void:
	if enemy_card_on_screen and fade_out_card:
		if $EnemyCard.get_child_count():
			fade_card($EnemyCard.get_child(0), 1.5)
		enemy_card_on_screen = false
		fade_out_card = false
		
	message()
	interactive_cards()
	next_turn()

func message() -> void:
	if Globals.current_player == player and Globals.discard_flag:
		$UI/Msg.text = "DISCARD CARD!"
	elif Globals.current_player == player:
		$UI/Msg.text = "YOUR TURN!"
	elif Globals.current_player == enemy:
		$UI/Msg.text ="ENEMY'S TURN!"
		
func fade_card(card: Card, rate: float) -> void:
	var t = create_tween()
	t.tween_property(card, "modulate", Color(1, 1, 1, 0), rate)
		
func interactive_cards() -> void:
	if Globals.current_card and Globals.current_card.card_owner == player:
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(Globals.current_card, "scale", Vector2(1.2,1.2), 0.3)
		last_card = Globals.current_card
		
	if not Globals.current_card and last_card:
		if str(last_card) == "<Freed Object>":
			last_card = null
		else:
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(last_card, "scale", Vector2(1, 1), 0.3)
			last_card = null
			
func can_play_card() -> bool:
	return Globals.current_card and Globals.current_player == player and Globals.current_card.card_owner == player
	
func discard_card(card: Card) -> void:
	if can_play_card():
		delete_card(card)
		update_player_hand()
		hand_over_turn()
	
func _input(event):
	if event.is_action_released("left_click"):
		if Globals.discard_flag:
			discard_card(Globals.current_card)
			Globals.discard_flag = false
			return
			
		if can_play_card():
			player_move()

	if event.is_action_released("right_click"):
		if Globals.current_card:
			discard_card(Globals.current_card)
			
func hand_over_turn() -> void:
	if Globals.current_player == player:
		Globals.current_player = enemy
		Globals.current_enemy = player
	else:
		Globals.current_player = player
		Globals.current_enemy = enemy
	$Timers/TurnPauseTimer.start()

func _process(_delta):
	debug_get_card_info(Globals.current_card)
	update_game()

func _on_fade_out_card_timer_timeout():
	fade_out_card = true

func _on_turn_pause_timer_timeout():
	turn_pause_timer_ended = true
