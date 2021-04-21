extends Node2D

onready var stats_ui = get_parent().get_node("canvas/stats")

var level = 1
var curr_exp = 0
var max_exp = 10
var health
var max_health = 10
var attack = 4
var defense = 5
var speed = 6

func _ready():
	level = 1
	health = max_health
	
	stats_ui.get_node("vbox/exp").max_value = max_exp
	
	update_stats()
	pass

func compute_exp(exp_amount):
	while exp_amount > 0:
		var needed_exp = max_exp - curr_exp
		if exp_amount >= needed_exp: #needed exp to level
			exp_amount -= needed_exp
			curr_exp += needed_exp
			stats_ui.get_node("vbox/exp").value = curr_exp
		else: #just add the exp amount to what is current, no level ups
			curr_exp += exp_amount
			exp_amount = 0
			stats_ui.get_node("vbox/exp").value = curr_exp
		
		if curr_exp == max_exp:
			get_parent().get_node("canvas/level_up").level_up()
	pass

func exp_roll():
	var exp_total = 5 * level
	print(exp_total)
	compute_exp(exp_total)
	pass

func update_hp():
	var hp = stats_ui.get_node("vbox/vbox/health")
	hp.text = " HP: " + str(health) + " / " + str(max_health)

func update_stats():
	var lvl = stats_ui.get_node("vbox/hbox/vbox/level")
	var hp = stats_ui.get_node("vbox/vbox/health")
	var atk = stats_ui.get_node("vbox/vbox/attack")
	var def = stats_ui.get_node("vbox/vbox/defense")
	var spd = stats_ui.get_node("vbox/vbox/speed")
	
	lvl.text = "Level: " + str(level)
	hp.text = " HP: " + str(health) + " / " + str(max_health)
	atk.text = " ATK: " + str(attack)
	def.text = " DEF: " + str(defense)
	spd.text = " SPD: " + str(speed)

func on_level_up():
	level += 1
	
	max_health += 2
	health = max_health
	attack += 1
	defense += 1
	speed += 1
	
	curr_exp = 0
	max_exp += (5 * level)
	print("max exp: " + str(max_exp))
	stats_ui.get_node("vbox/exp").value = curr_exp
	stats_ui.get_node("vbox/exp").max_value = max_exp
	
	update_stats()



