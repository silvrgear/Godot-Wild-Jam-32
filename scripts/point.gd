extends HBoxContainer

var enemies

var target

func _ready():
	enemies = get_parent().get_node("enemies")
	pass

func set_init_target():
	target = enemies.get_child(0)
	for i in range(0, get_child_count(), 1):
		if i == 0: 
			get_child(0).visible = true
			target = enemies.get_child(0)
		else:
			get_child(i).visible = false

func target_change(idx):
	for i in range(0, get_child_count(), 1):
		if i == idx: 
			get_child(i).visible = true
			target = enemies.get_child(i)
		else:
			get_child(i).visible = false
	pass
