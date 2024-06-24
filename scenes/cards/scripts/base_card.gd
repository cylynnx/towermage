extends Node2D
class_name BaseCard

func _on_area_2d_mouse_entered():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.36, 0.36), 0.2)
	
func _on_area_2d_mouse_exited():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.35, 0.35), 0.2)

func _on_button_pressed():
	print("Clicked On!")
