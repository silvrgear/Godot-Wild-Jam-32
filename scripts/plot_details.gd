extends NinePatchRect

onready var blank = load("res://sprites/enemies/blank_icon.png")

var m
var list
var ray

var outcome

func _ready():
	m = null
	set_outcome(outcome)
	
	#now works, don't change anything
	ray = get_parent().get_parent().get_node("player/ray")
	ray.enabled = true
	var mun
	ray.force_raycast_update()
	if ray.is_colliding() == true:
		mun = ray.get_collider()
		print("colliding")
		set_details(mun)
	else: return

func set_details(mons):
	m = mons.monsters.values()
	list = $vbox/curr_monsters
	
	for i in range(0, list.get_child_count(), 1):
		if list.get_child(i).texture == blank:
			list.get_child(i).texture = def_texture(m)
	pass

func def_texture(mon):
	var tex
	
	#set texture icon for each monster
	for i in range(0, mon.size(), 1):
		if mon[0] >= 1:
			tex = load("res://sprites/enemies/worm_icon.png")
			mon[0] -= 1
			return tex
		if mon[1] >= 1:
			tex = load("res://sprites/enemies/wormgator_icon.png")
			mon[1] -= 1
			return tex
		if mon[2] >= 1:
			tex = load("res://sprites/enemies/mole_icon.png")
			mon[2] -= 1
			return tex
		if mon[3] >= 1:
			tex = load("res://sprites/enemies/miner_mole_icon.png")
			mon[3] -= 1
			return tex
		if mon[4] >= 1:
			tex = load("res://sprites/enemies/wulf_icon.png")
			mon[4] -= 1
			return tex
		if mon[5] >= 1:
			tex = load("res://sprites/enemies/wulf_pack_icon.png")
			mon[5] -= 1
			return tex
		if mon[6] >= 1:
			tex = load("res://sprites/enemies/gobkin_icon.png")
			mon[6] -= 1
			return tex
		if mon[7] >= 1:
			tex = load("res://sprites/enemies/gobking_icon.png")
			mon[7] -= 1
			return tex
	pass

func set_outcome(word):
	var addm_icon = $vbox/hbox/monster_icon
	var mname = $vbox/hbox/name
	
	match word:
		"worm":
			addm_icon.texture = load("res://sprites/enemies/worm_icon.png")
			mname.text = "Worm"
		"mole":
			addm_icon.texture = load("res://sprites/enemies/mole_icon.png")
			mname.text = "Mole"
		"wulf": 
			addm_icon.texture = load("res://sprites/enemies/wulf_icon.png")
			mname.text = "Wulf"
		"gobk": 
			addm_icon.texture = load("res://sprites/enemies/gobkin_icon.png")
			mname.text = "Gobkin"

func remove_textures():
	list = $vbox/curr_monsters
	for i in range(0, list.get_child_count(), 1):
		list.get_child(i).texture = blank
	
	ray.enabled = false
	self.queue_free()



