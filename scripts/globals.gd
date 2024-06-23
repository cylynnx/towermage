extends Node

var player: Node = null
var enemy: Node = null

var enemy_list: Array[String] = ["Goblin Lord", "Dark Knight", "Dragon Mage"]
var enemy_selector: int = 0
var current_card: Node = null
var discard_flag: bool = false
var current_player: Player = null
var current_enemy: Player = null
var turn_ended: bool = false
