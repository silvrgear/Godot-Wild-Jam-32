extends Area2D

onready var battle_scn = preload("res://entities/battle_scn.tscn")

export (int) var north = 0
export (int) var east = 0
export (int) var west = 0
export (int) var south = 0

var monsters = {"worm": 1, "wormgator": 0, "mole": 0, "miner_mole": 0, "wulf": 0,
				"wulf_pack": 0, "gobk": 0, "gobking": 0}
var enemies = 0

func _ready():
	pass

func set_outcome(id): #after pressing yes in confirm_move
	if enemies < 6:
		match id:
			"worm":
				monsters.worm += 1
				if monsters.worm == 3:
					monsters.worm = 0
					enemies -= 2
					monsters.wormgator += 1
				
				enemies += 1
			"mole":
				monsters.mole += 1
				if monsters.mole == 3:
					monsters.mole = 0
					enemies -= 2
					monsters.miner_mole += 1
				
				enemies += 1
			"wulf":
				monsters.wulf += 1
				if monsters.wulf == 3:
					monsters.wulf = 0
					enemies -= 2
					monsters.wulf_pack += 1
				
				enemies += 1
			"gobk":
				monsters.gobk += 1
				if monsters.gobk == 3:
					monsters.gobk = 0
					enemies -= 2
					monsters.gobking += 1
				
				enemies += 1
			"none": pass
			"lvlu": pass
			"artf": pass
	
	play_event()
	print(monsters)
	pass

func play_event():
	var enemies = monsters.values()
	for i in range(0, enemies.size(), 1):
		if enemies[i] >= 1:
			print("there are enemies")
			var b = battle_scn.instance()
			get_parent().get_parent().get_node("canvas").add_child(b)
			b.set_opponents(monsters)
			return
	
	#show a big rect in the center. this will contain the battles
	#if there are enemies, go to battle mode.
	#get gold if there's any.
	pass





