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
	
	get_parent().get_parent().get_node("turn_order").get_all_participants()
	pass

func instance_enemy_card(mname):
	var t = tex_mon.instance()
	self.add_child(t)
	
	match mname: #update stats(hp, atk, def, spd, exp)
		"worm":
			t.get_node("tex").texture = load("res://sprites/enemies/worm.png")
			t.icon = "res://sprites/enemies/worm_icon.png"
			t.update_stats(2, 2, 1, 2, 2)
		"wormgator":
			t.get_node("tex").texture = load("res://sprites/enemies/wormgator.png")
			t.icon = "res://sprites/enemies/wormgator_icon.png"
			t.update_stats(18, 12, 10, 16, 30)
		"mole":
			t.get_node("tex").texture = load("res://sprites/enemies/mole.png")
			t.icon = "res://sprites/enemies/mole_icon.png"
			t.update_stats(8, 2, 3, 3, 3)
		"miner_mole":
			t.get_node("tex").texture = load("res://sprites/enemies/miner_mole.png")
			t.icon = "res://sprites/enemies/miner_mole_icon.png"
			t.update_stats(24, 8, 14, 10, 30)
		"wulf":
			t.get_node("tex").texture = load("res://sprites/enemies/wulf.png")
			t.icon = "res://sprites/enemies/wulf_icon.png"
			t.update_stats(4, 8, 3, 6, 4)
		"wulf_pack":
			t.get_node("tex").texture = load("res://sprites/enemies/wulf_pack.png")
			t.icon = "res://sprites/enemies/wulf_pack_icon_icon.png"
			t.update_stats(16, 20, 8, 18, 30)
		"gobk":
			t.get_node("tex").texture = load("res://sprites/enemies/gobkin.png")
			t.icon = "res://sprites/enemies/gobkin_icon.png"
			t.update_stats(8, 8, 4, 5, 5)
		"gobking":
			t.get_node("tex").texture = load("res://sprites/enemies/gobking.png")
			t.icon = "res://sprites/enemies/gobking_icon.png"
			t.update_stats(34, 18, 24, 16, 50)
		"boss":
			randomize()
			t.get_node("tex").texture = load("res://sprites/enemies/boss.png")
			t.icon = "res://sprites/enemies/boss_icon.png"
			t.update_stats(200 + randi() % 20 + 1, 30 + randi() % 20 + 1, 30 + randi() % 20 + 1, 40 + randi() % 20 + 1, 100)






