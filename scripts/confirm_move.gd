extends NinePatchRect

var main


func _ready():
	main = get_parent().get_parent()
	pass

func _on_yes_btn_button_down():
	$yes_btn/label.anchor_top = 0.5
	pass # Replace with function body.

func _on_yes_btn_button_up():
	$yes_btn/label.anchor_bottom = 0.4
	pass # Replace with function body.

func _on_no_btn_button_down():
	$no_btn/label.anchor_top = 0.5
	pass # Replace with function body.

func _on_no_btn_button_up():
	$no_btn/label.anchor_bottom = 0.4
	pass # Replace with function body.

func _on_yes_btn_pressed():
	var p = main.get_node("player")
	p.curr_plot.set_outcome(p.outcome)
	
	p.get_node("canvas/stats").visible = false
	main.get_node("canvas/avail_moves").visible = false
	
	#remove outcome after confirming
#	p.outcome = null
	
#	main.get_node("canvas/roll_mgr").enable_rolling()
#	main.get_node("lines").clear_points()
	
	main.get_node("canvas/plot_details").remove_textures()
	self.queue_free()
	pass # Replace with function body.

func _on_no_btn_pressed():
	var p = main.get_node("player")
	p.return_to_orig_position()
	
	main.get_node("canvas/plot_details").remove_textures()
	self.queue_free()
	pass # Replace with function body.







