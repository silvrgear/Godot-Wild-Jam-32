extends Control

var turn_order = []

func _ready():
	set_player_stats()
	pass

func set_player_stats():
	var p = get_parent().get_parent().get_node("player/stats")
	
	$dummy/health.text = str(p.health)
	$dummy/attack.text = str(p.attack)
	$dummy/defense.text = str(p.defense)
	$dummy/speed.text = str(p.speed)

func set_opponents(mon):
	var m = mon.values()
	var enemies = []
	
	for i in range(0, m.size(), 1):
		while m[i] >= 1:
			match i:
				0: 
					enemies.append("worm")
					m[i] -= 1
				1:
					enemies.append("wormgator")
					m[i] -= 1
				2: 
					enemies.append("mole")
					m[i] -= 1
				3: 
					enemies.append("miner_mole")
					m[i] -= 1
				4: 
					enemies.append("wulf")
					m[i] -= 1
				5: 
					enemies.append("wulf_pack")
					m[i] -= 1
				6: 
					enemies.append("gobk")
					m[i] -= 1
				7:
					enemies.append("gobking")
					m[i] -= 1
	
	$panel/hbox/details/enemies.spawn_enemies(enemies)
	pass
