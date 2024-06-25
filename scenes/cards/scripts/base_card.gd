class_name BaseCard extends Node2D

signal clicked_on(id: int)

enum CardType {RESOURCE, MAGIC, CREATURE}

@export var card_id: int
@export var description: String
@export var card_type: CardType
@export var card_cost: int
	
func _on_area_2d_mouse_entered():
	$Sound/SoundPlayer.play()
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.36, 0.36), 0.2)
	
func _on_area_2d_mouse_exited():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.35, 0.35), 0.2)

func _on_clicker_pressed():
	clicked_on.emit(card_id)
