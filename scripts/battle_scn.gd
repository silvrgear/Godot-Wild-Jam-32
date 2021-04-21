extends Control

signal battle_finished

var turn_order = []
var total_exp

func _ready():
	get_parent().get_node("avail_moves").visible = false
	total_exp = 0
	
	connect("battle_finished", get_parent().get_node("roll_mgr"), "enable_rolling")
	pass

func take_exp_from_kills(exp_amount):
	total_exp += exp_amount
	print("TOTAL EXP: " + str(total_exp))
	pass

func give_exp():
	var player_stats = get_parent().get_parent().get_node("player/stats")
	player_stats.compute_exp(total_exp)
	pass

func set_opponents(mon):
	var p = get_parent().get_parent().get_node("player")
	if p.on_boss == true:
		$boss_battle.play()
	else:
		$battle_mode.play()
	
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
				8:
					enemies.append("boss")
					m[i] -= 1
	
	$panel/hbox/details/enemies.spawn_enemies(enemies)
	pass

func check_sides():
	if $dummy.health == 0:
		#player loses
		print("you died")
		
		total_exp = 0
		
		$battle_mode.stop()
		$boss_battle.stop()
#		$panel/battle.visible = false
#		$panel/battle.disabled = true
		$defeat.play()
	
	if $panel/hbox/details/enemies.get_child_count() == 0:
		
		#player wins
		print("no enemies left")
		print("EXP: " + str(total_exp))
		give_exp()
		
		var p = get_parent().get_parent().get_node("player")
		p.get_node("stats").health = get_node("dummy").health
		p.get_node("stats").update_hp()
		
		if p.on_boss == true:
			get_tree().change_scene("res://scenes/you_win_scrn.tscn")
			return
		
		#show victory
		emit_signal("battle_finished")
		#pass current hp of dummy to player scene
		self.queue_free()
	else: #there are enemies left
		#wait for the removal of enemies that are dead
		for i in get_node("panel/hbox/details/enemies").get_children():
			if i.health == 0:
				yield(i, "tree_exited")
		
		get_node("panel/hbox/turn_order").get_all_participants()
		$panel/battle.visible = true
		$panel/battle.disabled = false

func _on_battle_button_down():
	$panel/battle/label.anchor_top = 0.6
	pass # Replace with function body.

func _on_battle_button_up():
	$panel/battle/label.anchor_bottom = 0.5
	pass # Replace with function body.





func _on_defeat_finished():
	emit_signal("battle_finished")
	get_tree().change_scene("res://scenes/main_menu.tscn")
	self.queue_free()
	pass # Replace with function body.
