extends VBoxContainer

signal enemies_ready

onready var turn_card = preload("res://entities/turn_card.tscn")

var player
var enemies

func _ready():
	player = owner.get_node("dummy")
	enemies = get_parent().get_node("details/enemies")
	
	connect("enemies_ready", get_parent().get_node("details/point"), "set_init_target")
	pass

func get_all_participants():
	create_turn_card(player)
	
	for i in enemies.get_children():
		create_turn_card(i)
	
	turn_queue_sort()
	get_parent().get_node("details/point").set_init_target()
	emit_signal("enemies_ready")

func turn_queue_sort():
	var battlers = self.get_children()
	
	battlers.sort_custom(self, "sort_battlers")
	for x in battlers:
		x.raise()
	pass

func sort_battlers(a, b) -> bool:
	return a.speed > b.speed

func create_turn_card(unit):
	var x = turn_card.instance()
	add_child(x)
	x.texture = load(unit.icon)
	x.speed = unit.speed
	x.unit_path = unit.get_path()
	get_node(unit.get_path()).turn_order_card = x
	x.name = "turn_card" + str(get_child_count())
	pass

func start_battle():
	var battle_btn = get_parent().get_parent().get_node("battle")
	battle_btn.visible = false
	battle_btn.disabled = true
	
	var active = get_child(0)
	get_node(active.unit_path).attack()
	pass

func next_battler():
	if is_instance_valid(get_child(0)) == false:
		get_parent().get_parent().get_parent().check_sides()
		return
	
	get_child(0).queue_free()
	#wait for the first unit to remove itself
	yield(get_child(0), "tree_exited")
	
	if get_child_count() >= 1:
		get_node(get_child(0).unit_path).attack()
	else:
		for i in get_parent().get_node("details/enemies").get_children():
			if i.health == 0:
				yield(i, "tree_exited")
		
		#no battlers left
		get_parent().get_parent().get_parent().check_sides()
		pass
	pass


func _on_battle_pressed():
	get_parent().get_parent().get_node("battle/click").play()
	start_battle()
	pass # Replace with function body.






