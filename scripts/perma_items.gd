extends Node

onready var item = preload("res://entities/item.tscn")
onready var acq = preload("res://entities/acquired.tscn")

var items = {"trident": 0, "gloves": 0, "drink": 0, "cheesus": 0}

var stats
var player
var canvas

var item_array = []

func _ready():
	pass

func add_initial_stats():
	if items.trident > 0:
		set_item_effect(items.trident * 2, "attack")
	if items.gloves > 0:
		set_item_effect(items.gloves * 2, "speed")
	if items.drink > 0:
		set_item_effect(items.drink * 2, "defense")
	if items.cheesus > 0:
		set_item_effect(items.cheesus * 2, "health")

func spawn_random_item():
	randomize()
	
	var roll = randi() % 4 + 1
	var type
	var stat
	match roll:
		1: 
			type = "trident" 
			stat = "attack"
			spawn_acquired("Trident of Zyus")
			items.trident += 1
		2: 
			type = "gloves" 
			stat = "speed"
			spawn_acquired("Ancient Gloves of Haste")
			items.gloves += 1
		3: 
			type = "drink" 
			stat = "defense"
			spawn_acquired("Unknown Yellowish Drink")
			items.drink += 1
		4: 
			type = "cheesus" 
			stat = "health"
			spawn_acquired("Milk of Cheesus")
			items.cheesus += 1
	print(items)
	#if item is in slot, just add stack
	if item_array.has(type) == true:
		for i in $hbox.get_children():
			if i.item_name == type:
				i.stack += 1
				i.get_node("label").text = "x" + str(i.stack)
		
		set_item_effect(4, stat)
	#item is not in slot. instance item
	else:
		item_array.append(type)
		
		var x = item.instance()
		$hbox.add_child(x)
		x.texture = load("res://sprites/items/" + str(type) + ".png")
		x.item_name = type
		x.stack = 1
		x.get_node("label").text = "x" + str(x.stack)
		set_item_effect(2, stat)
	pass

func spawn_acquired(item):
	canvas = get_node("/root").get_child(1).get_node("canvas")
	
	var x = acq.instance()
	canvas.add_child(x)
	x.get_node("label").text = "Acquired " + str(item)
	pass

func set_item_effect(num, stat):
	player = get_node("/root").get_child(1).get_node("player")
	
	stats = player.get_node("stats")
	
	match stat:
		"attack": stats.attack += num
		"speed": stats.speed += num
		"defense": stats.defense += num
		"health":
			stats.max_health += num
			stats.health += num
	
	stats.update_stats()
	pass



