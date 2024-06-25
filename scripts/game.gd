class_name Game extends Node2D

enum CardsEnum {
	Agriculture, Husbandry, Brick_Shortage, Full_Moon  
	}
	
func _ready():
	var agriculture_card: BaseCard = Cards.Agriculture.instantiate() as BaseCard
	agriculture_card.position = Vector2(200.0, 300.0)
	agriculture_card.clicked_on.connect(_on_card_pressed)
	add_child(agriculture_card)
	
	var husbandry_card: BaseCard = Cards.Husbandry.instantiate() as BaseCard
	husbandry_card.position = Vector2(600.0, 300.0)
	husbandry_card.clicked_on.connect(_on_card_pressed)
	add_child(husbandry_card)

func _on_card_pressed(id: int):
	match id:
		CardsEnum.Agriculture:
			print("Agri pressed")
		CardsEnum.Husbandry:
			print("Husbandry pressed")
