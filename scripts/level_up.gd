extends Control

func _ready():
	pass

func level_up():
	self.visible = true
	$anim.play("pop")
	
	get_parent().get_parent().get_node("stats").on_level_up()


func _on_anim_animation_finished(anim_name):
	if anim_name == "pop":
		self.visible = false
	pass # Replace with function body.
