class_name Deck
extends Node2D

const CARD_SCENE: PackedScene = preload("res://scenes/card.tscn")

const DECK_SIZE: int = 64

enum {TEXTURE, BOARDER, DESCRIPTION, RESOURCE_COST, MANA_COST, CREATURE_COST, CAN_DISCARD}
	
var card_map: Dictionary = {
	"Agriculture" : [
		"res://assets/Cards/Agriculture/art_Agriculture.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+2 food.",
		0, 0, 5,
		true
	],
	
	"Husbandry" : [
		"res://assets/Cards/Husbandry/art_Husbandry.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+1 food.",
		0, 0, 3,
		true
	],
	
	"Brick Shortage" : [
		"res://assets/Cards/Brick Shortage/art_BrickShortage.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"All players lose 8 resources.",
		0, 0, 0,
		true
	],
	
	"Full Moon" : [
		"res://assets/Cards/Full Moon/art_FullMoon.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+1 To all player's food. You gain 3 creatures.",
		0, 0, 0,
		true
	],
	
	"Portcullis" : [
		"res://assets/Cards/Portcullis/art_Portcullis.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+5 wall, +1 food.",
		9, 0, 0,
		true
	],
	
	"New Equipment" : [
		"res://assets/Cards/New Equipment/art_NewEquipment.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"+2 mine.",
		6, 0, 0,
		true
	],
	
	"Fairy" : [
		"res://assets/Cards/Fairy/art_fairy_resized.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"2 damage. Play Again!",
		0, 0, 1,
		true
		],
	
	"Shadow Fairy" : [
		"res://assets/Cards/Shadow Fairy/art_ShadowFairy.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"2 damage to enemy tower. Play again!",
		0, 0, 3,
		true
	],
		
	"Elven Scout" : [
		"res://assets/Cards/Elven Scout/art_ElvenScout_resized.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"Discard 1 card, draw 1 card.",
		0, 0, 0,
		true
	],
	
	"Goblin Archers" : [
		"res://assets/Cards/Goblin Archers/art_GoblinArcher.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"3 damage to enemy tower. You take 1 damage.",
		0, 0, 3,
		true
	],
	
	"Moody Goblins" : [
		"res://assets/Cards/Moody Goblins/art_MoodyGoblins.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"4 damage. You lose 3 mana.",
		0, 0, 1,
		true
	],
	
	"Goblin Mob" : [
		"res://assets/Cards/Goblin Mob/art_GoblinMob.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"6 Damage. You take 3 Damage.",
		0, 0, 3,
		true
	],
	
	"Rabbid Sheep" : [
		"res://assets/Cards/Rabbid Sheep/art_RabbidSheep.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"6 damage. Enemy losses 3 creatures.",
		0, 0, 5,
		true
	],
	
	"Ogre" : [
		"res://assets/Cards/Ogre/art_Ogre.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"7 damage.",
		0, 0, 5,
		true
	],
	
	"Orc" : [
		"res://assets/Cards/Orc/art_Orc.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"5 damage.",
		0, 0, 3,
		true
	],
	
	"Slasher" : [
		"res://assets/Cards/Slasher/art_Slasher.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"6 damage.",
		0, 0, 3,
		true
	],
	
	"Werewolf": [
		"res://assets/Cards/Werewolf/art_Werewolf.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"9 damage.",
		0, 0, 6,
		true
	],
	
	"Imp" : [
		"res://assets/Cards/Imp/art_Imp.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"6 damage. All players lose 5 resources, 5 mana, 5 creatures.",
		0, 0, 3,
		true
	],
	
	"Spitter Spider" : [
		"res://assets/Cards/Spitter Spider/art_SpitterSpider.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"If enemy wall = 0, 10 damage. Else 6 damage.",
		0, 0, 7,
		true
	],
	
	"Corrosive Cloud" : [
		"res://assets/Cards/Corrosive Cloud/art_CorrosiveCloud.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"If enemy wall bigger than 0, 10 damage, else 7 damage.",
		0, 0, 8,
		true
	],
	
	"Elven Archer" : [
		"res://assets/Cards/Elven Archer/art_ElvenArcher.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"If wall bigger than enemy wall, 7 damage to enemy tower, else 7 damage.",
		0, 0, 7,
		true
	],
	
	"Dwarf" : [
		"res://assets/Cards/Dwarf/art_Dwarf.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"4 damage, +3 wall.",
		0, 0, 3,
		true
	],
	
	"Work Overtime" : [
		"res://assets/Cards/Work Overtime/art_WorkingOvertime.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+5 wall. You lose 6 mana.",
		2, 0, 0,
		true
	],
	
	"Crystal Rocks" : [
		"res://assets/Cards/Crystal Rocks/art_CrystalRocks.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+7 wall. Gain 7 mana.",
		9, 0, 0,
		true
	],
	
	"Harmonic Ore" : [
		"res://assets/Cards/Harmonic Ore/art_HarmonicOre.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"+6 wall, +3 tower.",
		11, 0, 0,
		true
	],
	
	"Friendly Terrain" : [
		"res://assets/Cards/Friendly Terrain/art_FriendlyTerrain.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+1 wall. Play again!",
		5, 0, 0,
		true
	],
	
	"Foundation" : [
		"res://assets/Cards/Foundation/art_Foundation.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"If player wall is 0, +6 wall, +3 if otherwise.",
		3, 0, 0,
		true
	],
	
	"Forced Labor" : [
		"res://assets/Cards/Forced Labor/art_ForcedLabor.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"+9 wall. Lose 5 creatures.",
		6, 0, 0,
		true
	],
	
	"Basic Wall" : [
		"res://assets/Cards/Basic Wall/art_BasicWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+3 wall.",
		2, 0, 0,
		true
	],
	
	"Sturdy Wall" : [
		"res://assets/Cards/Sturdy Wall/art_SturdyWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+4 wall.",
		3, 0, 0,
		true
	],
	
	"Big Wall" : [
		"res://assets/Cards/Big Wall/art_BigWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+6 wall.",
		5, 0, 0,
		true
	],
	
	"Reinforced Wall" : [
		"res://assets/Cards/Reinforced Wall/art_ReinforcedWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+8 wall.",
		7, 0, 0,
		true
	],
	
	"Castle Wall" : [
		"res://assets/Cards/Castle Wall/art_CastleWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+12 wall.",
		12, 0, 0,
		true
	],
	
	"Great Wall" : [
		"res://assets/Cards/Great Wall/art_GreatWall.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+15 wall.",
		16, 0, 0,
		true
	],
	
	"Stone Giant" : [
		"res://assets/Cards/Strone Giant/art_StoneGiant.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"10 damage, +4 wall.",
		12, 0, 0,
		true
	],
	
	"Dwarven Miners" : [
		"res://assets/Cards/Dwarven Miners/art_DwarfMiners.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"+4 wall, +1 mine.",
		6, 0, 0,
		true
	],
	
	"Focused Designs" : [
		"res://assets/Cards/Focused Designs/art_FocusedDesigns.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+8 wall, +5 tower.",
		14, 0, 0,
		true
	],
	
	"Crystal Shield" : [
		"res://assets/Cards/Crystal Shield/art_CrystalShield.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+8 tower, +3 wall.",
		0, 12, 0,
		true
	],
	
	"Strip Mine" : [
		"res://assets/Cards/Strip Mine/art_StripMine.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"-1 mine, +10 wall. You gain 5 mana.",
		0, 0, 0,
		true
	],
	
	"Tower Gremlin" : [
		"res://assets/Cards/Tower Gremlin/art_TowerGremlin.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"2 damage, +4 wall, +2 tower.",
		0, 0, 4,
		true
	],
	
	"Miner" : [
		"res://assets/Cards/Miner/art_Miner.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"+1 mine",
		4, 0, 0,
		true
	],
	
	"Coppin' the Tech" : [
		"res://assets/Cards/Coppin' The Tech/art_CoppinTheTech.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"If your mine is less than the enemy's, then your mine becomes equal to the enemy's.",
		5, 0, 0,
		true
	],
	
	"Quarry's Help" : [
		"res://assets/Cards/Quarry's Help/art_QuarrysHelp.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+7 tower. Lose 10 resources.",
		0, 3, 0,
		true
	],
	
	"Innovations" : [
		"res://assets/Cards/Innovations/art_Inovations.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+1 to all player's mines. You gain 4 mana.",
		2, 0, 0,
		true
	],
	
	"Parity" : [
		"res://assets/Cards/Parity/art_Parity.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"All players magic equals to the highest player's magic.",
		0, 5, 0,
		true
	],
	
	"Spell Thief" : [
		"res://assets/Cards/Spell Thief/art_SpellThief.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"-1 enemy Tower, enemy loses 10 mana, 5 resources, you gain half the amount.",
		0, 0, 7,
		true
	],
	
	"Rock Thrower" : [
		"res://assets/Cards/Rock Thrower/art_RockThrower.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"+6 wall, 10 damage to enemy.",
		14, 0, 0,
		true
	],
	
	"Rock Stomper" : [
		"res://assets/Cards/Rock Stomper/art_RockStomper.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"8 damage, -1 enemy mine.",
		0, 0, 10,
		true
	],
	
	"Fire Ruby" : [
		"res://assets/Cards/Fire Ruby/art_FireRuby.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+6 tower. 4 damage to enemy tower.",
		0, 15, 0,
		true
	],
	
	"Little Snakes" : [
		"res://assets/Cards/Little Snakes/art_LittleSnakes.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"4 damage to enemy tower",
		0, 6, 0,
		true
	],
	
	"Smoky Quartz" : [
		"res://assets/Cards/Smoky Quartz/art_SmokyQuartz.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"1 damage to enemy tower. Play again!",
		0, 2, 0,
		true
	],
	
	"Gem Spear" : [
		"res://assets/Cards/Gem Spear/art_GemSpear2.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"5 damage to enemy tower",
		0, 5, 0,
		true
	],
	
	"Pearl of Wisdom" : [
		"res://assets/Cards/Pearl of Wisdom/art_PearlOfWisdom.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+5 tower, +1 magic.",
		0, 9, 0,
		true
	],
	
	"Prism" : [
		"res://assets/Cards/Prism/art_Prism.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"Draw 1 card, discard 1 card. Play Again!",
		0, 1, 0,
		true
	],
	
	"Power Burn" : [
		"res://assets/Cards/Power Burn/art_PowerBurn.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"10 damage to your tower, +2 magic.",
		0, 2, 0,
		true
	],
	
	"Solar Flare" : [
		"res://assets/Cards/Solar Flare/art_SolarFlare.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"+2 tower. 2 damage to enemy tower.",
		0, 4, 0,
		true
	],
	
	"Sanctuary" : [
		"res://assets/Cards/Sanctuary/art_Sanctuary.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+10 tower, +5 wall, gain 5 creatures.",
		0, 15, 0,
		true
	],
	
	"Empathy Gem" : [
		"res://assets/Cards/Empathy Gem/art_EmpathyGem.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+8 tower, +1 food.",
		0, 13, 0,
		true
	],
	
	"Dragon's Eye" : [
		"res://assets/Cards/Dragon's Eye/art_DragonsEye.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+20 tower.",
		0, 20, 0,
		true
	],
	
	"Diamond" : [
		"res://assets/Cards/Diamond/art_Diamond.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+15 tower.",
		0, 16, 0,
		true
	],
	
	"Sapphire" : [
		"res://assets/Cards/Saphire/art_Saphire.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+10 tower.",
		0, 10, 0,
		true
	],
	
	"Emerald" : [
		"res://assets/Cards/Emerald/art_Emerald.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+8 tower.",
		0, 6, 0,
		true
	],
	
	"Ruby" : [
		"res://assets/Cards/Ruby/art_Ruby.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+5 tower.",
		0, 3, 0,
		true 
	],
	
	"Amethyst": [
		"res://assets/Cards/Amethyst/art_Amethyst.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+3 tower.",
		0, 2, 0,
		true
	],
	
	"Quartz" : [
		"res://assets/Cards/Quartz/art_Quartz.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+1 Tower. Play Again!",
		0, 1, 0,
		true
	],
	
	"Secret Room" : [
		"res://assets/Cards/Secret Room/art_SecretRoom.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+1 Magic. Play Again!",
		9, 0, 0,
		true
	],
	
	"Gemstone Flaw" : [
		"res://assets/Cards/Gemstone Flaw/art_GemstoneFlaw.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"3 damage to enemy tower.",
		0, 2, 0,
		true
	],
	
	"Shatterer" : [
		"res://assets/Cards/Shatterer/art_Shaterer.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"-1 magic. 9 damage to enemy tower.",
		0, 8, 0,
		true
	],
	
	"Crumblestone" : [
		"res://assets/Cards/Crumblestone/art_Crumblestone.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"+5 tower. Enemy loses 6 resources.",
		0, 7, 0,
		true
	],
	
	"Mad Cow Disease" : [
		"res://assets/Cards/Mad Cow Disease/art_MadCow.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"All players lose 8 creatures",
		0, 0, 0,
		true
	],
	
	"Discord" : [
		"res://assets/Cards/Discord/art_Discord.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"7 damage to all towers. All player's magic -1.",
		0, 4, 0,
		true
	],
	
	"Tremors" : [
		"res://assets/Cards/Tremors/art_Tremors.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"All walls take 5 damage. Play Again!",
		7, 0, 0,
		true
	],
	
	"Lucky Cache": [
		"res://assets/Cards/Lucky Cache/art_LuckyCache.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+2 resources, +2 mana. Play again!",
		0, 0, 0,
		true
	],
	
	"Harmonic Vibe" : [
		"res://assets/Cards/Harmonic Vibe/art_HarmonicVibe.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+1 magic, +3 tower, +3 wall.",
		0, 7, 0,
		true
	],
	
	"Crystal Matrix" : [
		"res://assets/Cards/Crystal Matrix/art_CrystalMatrix.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+1 magic, +1 tower, +1 enemy tower.",
		0, 5, 0,
		true
	],
	
	"Dragon's Heart" : [
		"res://assets/Cards/Dragon's Heart/art_Dragon'sHeart.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"+20 wall, +8 tower.",
		0, 0, 24,
		true
	],
	
	"Lava Jewel" : [
		"res://assets/Cards/Lava Jewel/art_LavaJewel.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"+12 tower, 6 damage.",
		0, 17, 0,
		true
	],
	
	"Earthquake" : [
		"res://assets/Cards/Earthquake/art_Earthquake.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"-1 to all player's mines.",
		0, 0, 0,
		true
	],
	
	"Lodestone" : [
		"res://assets/Cards/Lodestone/art_Lodestone.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+3 tower. This card cannot be discarded without playing it.",
		0, 5, 0,
		false
	],
	
	"Mother Lode" : [
		"res://assets/Cards/Mother Lode/art_MotherLode.jpg",
		"res://assets/Borders/Resource_Boarder.png",
		"If mine less than enemy mine +2 mine, else +1 mine.",
		4, 0, 0,
		true
	],
	
	"Crystalize" : [
		"res://assets/Cards/Crystalize/art_Crystalize.jpg",
		"res://assets/Borders/Mana_Boarder2.png",
		"+11 tower, -6 wall.",
		0, 8, 0,
		true
	],
	
	"Spell Weavers" : [
		"res://assets/Cards/Spell Weavers/art_SpellWeavers.jpg",
		"res://assets/Borders/Mana_Boarder.png",
		"+1 magic.",
		0, 3, 0,
		true
	],
	
	"Unicorn" : [
		"res://assets/Cards/Unicorn/art_Unicorn.jpg",
		"res://assets/Borders/Creature_Boarder.png",
		"If magic bigger than enemy magic, 12 damage, else 8 damage.",
		0, 0, 8,
		true
	],
	
	"Vampire" : [
		"res://assets/Cards/Vampire/art_Vampire.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"10 damage, enemy loses 5 creatures, -1 enemy food.",
		0, 0, 11,
		true
	],
	
	"Succubus" : [
		"res://assets/Cards/Succubus/art_Succubus.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"5 damage to enemy tower, enemy loses 8 creatures.",
		0, 0, 10,
		true
	],
	
	"Dragon" : [
		"res://assets/Cards/Dragon/art_Dragon.jpg",
		"res://assets/Borders/Creature_Boarder2.png",
		"20 damage. Enemy loses 10 mana, -1 enemy food.",
		0, 0, 25,
		true
	]
	
}

var cards: Array[Card] = []

func get_cost(card: Card) -> String:
	if card.resource_cost:
		return str(card.resource_cost)
	elif card.mana_cost:
		return str(card.mana_cost)
	elif card.creature_cost:
		return str(card.creature_cost)
	return "F"
	
func get_color(card: Card) -> Color:
	if card.resource_cost:
		return Color(0.853, 0.344, 0)
	elif card.mana_cost:
		return Color(0.137, 0.447, 0.78)
	elif card.creature_cost:
		return Color(0.89, 0.58, 0.878)
	return Color(0,0,0,0)
	
func create(belongs_to: Player):
	for i in range(DECK_SIZE):
		var card = CARD_SCENE.instantiate() as Card
		var pic = card.get_child(0).get_child(0)
		var boarder = card.get_child(0).get_child(1)
		var txt = card.get_child(2)
		card.card_name = card_map.keys().pick_random()
		card.card_owner = belongs_to
		pic.scale = Vector2(0.25, 0.25)
		pic.texture = load(card_map[card.card_name][TEXTURE])
		boarder.scale = Vector2(0.28, 0.28)
		boarder.texture = load(card_map[card.card_name][BOARDER])
		card.card_description = card_map[card.card_name][DESCRIPTION]
		card.resource_cost = card_map[card.card_name][RESOURCE_COST]
		card.mana_cost = card_map[card.card_name][MANA_COST]
		card.creature_cost = card_map[card.card_name][CREATURE_COST]
		card.can_be_discarded = card_map[card.card_name][CAN_DISCARD]
		txt.text = get_cost(card)
		if int(txt.text) >= 10:
			txt.position -= Vector2(10, 0)
		txt.modulate = get_color(card)
		cards.append(card)
		
func create_single_card(_name: String, _belongs_to: Player) -> Card:
	var card = CARD_SCENE.instantiate() as Card
	var pic = card.get_child(0).get_child(0)
	var boarder = card.get_child(0).get_child(1)
	var txt = card.get_child(2)
	card.card_name = _name
	card.card_owner = _belongs_to
	pic.scale = Vector2(0.25, 0.25)
	pic.texture = load(card_map[card.card_name][TEXTURE])
	boarder.scale = Vector2(0.28, 0.28)
	boarder.texture = load(card_map[card.card_name][BOARDER])
	card.card_description = card_map[card.card_name][DESCRIPTION]
	card.resource_cost = card_map[card.card_name][RESOURCE_COST]
	card.mana_cost = card_map[card.card_name][MANA_COST]
	card.creature_cost = card_map[card.card_name][CREATURE_COST]
	card.can_be_discarded = card_map[card.card_name][CAN_DISCARD]
	txt.text = get_cost(card)
	if int(txt.text) >= 10:
		txt.position -= Vector2(10, 0)
	txt.modulate = get_color(card)
	return card
