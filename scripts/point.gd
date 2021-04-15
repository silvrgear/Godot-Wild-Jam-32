extends HBoxContainer

func _ready():
	pass

func target_change(idx):
	for i in range(0, get_child_count(), 1):
		if i == idx: 
			get_child(i).visible = true
		else:
			get_child(i).visible = false
	pass
