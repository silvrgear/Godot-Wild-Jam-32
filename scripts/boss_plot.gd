extends Area2D

onready var battle_scn = preload("res://entities/battle_scn.tscn")

export (int) var north = 0
export (int) var east = 0
export (int) var west = 0
export (int) var south = 0

var monsters = {"worm": 0, "wormgator": 0, "mole": 0, "miner_mole": 0, "wulf": 0,
				"wulf_pack": 0, "gobk": 0, "gobking": 0, "boss": 0}
var enemies = 0

func _ready():
	pass

func set_outcome(id): #after pressing yes in confirm_move
	monsters.boss += 1
	enemies += 1
	
	play_event()
	print("BOSS BATTLE" + str(id))
	pass

func play_event():
	var p = get_parent().get_parent().get_node("player")
	p.get_node("canvas/stats").visible = false
	p.on_boss = true
	
	var b = battle_scn.instance()
	get_parent().get_parent().get_node("canvas").add_child(b)
	b.set_opponents(monsters)
	pass





