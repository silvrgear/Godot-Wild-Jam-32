extends Control

func _ready():
	pass


func _on_anim_animation_finished(anim_name):
	if anim_name == "float":
		self.queue_free()
	pass # Replace with function body.
