class_name BaseCard extends Node2D

enum CardType {RESOURCE, MAGIC, CREATURE}

const RESOURCE_COLOR: Color = Color(0.853, 0.344, 0)
const MAGIC_COLOR: Color = Color(0.137, 0.447, 0.78)
const CREATURE_COLOR: Color = Color(0.89, 0.58, 0.878)

@export var description: String
@export var card_type: CardType
@export var card_cost: int

func _ready():
	match card_type:
		CardType.RESOURCE:
			$Cost.font_color = RESOURCE_COLOR
		CardType.MAGIC:
			$Cost.font_color = MAGIC_COLOR
		CardType.CREATURE:
			$Cost.font_color = CREATURE_COLOR
		_:
			$Cost.font_color = Color(0, 0, 0, 1)
			
	$Cost.text = str(card_cost)
	
func _on_area_2d_mouse_entered():
	$Sound/SoundPlayer.play()
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.36, 0.36), 0.2)
	
func _on_area_2d_mouse_exited():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.35, 0.35), 0.2)

func _on_button_pressed():
	print("Clicked On!")
