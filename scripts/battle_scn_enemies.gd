extends HBoxContainer

onready var tex_mon = preload("res://entities/enemy.tscn")

var can_change_target = true

func _ready():
	pass

func spawn_enemies(mon):
	while mon.empty() == false:
		print("mon" + str(mon))
		instance_enemy_card(mon[0])
		mon.pop_front()
	
	
	pass

func instance_enemy_card(mname):
	var t = tex_mon.instance()
	self.add_child(t)
	
	match mname:
		"worm":
			t.texture = load("res://sprites/enemies/worm.png")
			t.update_stats(2, 2, 1, 2)
		"wormgator":
			t.texture = load("res://sprites/enemies/wormgator.png")
			t.update_stats(16, 12, 10, 16)
		"mole":
			t.texture = load("res://sprites/enemies/mole.png")
			t.update_stats(5, 2, 4, 3)
		"miner_mole":
			t.texture = load("res://sprites/enemies/mole.png")
			t.update_stats(15, 8, 16, 12)
		"wulf":
			t.texture = load("res://sprites/enemies/wulf.png")
			t.update_stats(4, 5, 2, 6)
		"wulf_pack":
			t.texture = load("res://sprites/enemies/wulf_pack.png")
			t.update_stats(12, 15, 6, 18)
		"gobk":
			t.texture = load("res://sprites/enemies/gobkin.png")
			t.update_stats(8, 6, 4, 5)
		"gobking":
			t.texture = load("res://sprites/enemies/gobking.png")
			t.update_stats(25, 16, 18, 14)






