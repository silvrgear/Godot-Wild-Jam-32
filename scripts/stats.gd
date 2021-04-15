extends Node2D

onready var stats_ui = get_parent().get_node("canvas/stats")

var level = 1
var health
var max_health = 10
var attack = 3
var defense = 5
var speed = 2

func _ready():
	level = 1
	health = max_health
	update_stats()
	pass

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



