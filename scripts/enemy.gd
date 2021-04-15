extends TextureRect

signal selected(enemy)

var health = 0
var attack = 0
var defense = 0
var speed = 0

func _ready():
	connect("selected", get_parent().get_parent().get_node("point"), "target_change")
	pass

func update_stats(hp, atk, def, spd):
	$health.text = str(hp)
	$attack.text = str(atk)
	$defense.text = str(def)
	$speed.text = str(spd)


func _on_enemy1_gui_input(event):
	if get_parent().can_change_target == true:
		if event.is_action_pressed("click"):
			emit_signal("selected", self.get_index())
	pass # Replace with function body.
