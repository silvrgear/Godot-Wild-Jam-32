extends Control

signal moves_left(roll)

var player

var outcome = ""

func _ready():
	$roller.modulate = Color("#ffffff")
	$roller/label.rect_position.y = -64
	$roll_btn/label.anchor_bottom = 0.4
	
	player = get_parent().get_parent().get_node("player")
	pass

func randomize_roll():
	var i = 0
	$timer.wait_time = 0.008
	while i != 20:
		$anim.play("bounce")
		$timer.start()
		
		yield($timer, "timeout")
		
		randomize()
		var num = randi() % 7 + 1
		$roller/label.text = str(num)
		
		$timer.wait_time += 0.008
		i += 1
	
	last_roll()

func last_roll():
	$anim.play("last")
	player.move_history.clear()
	randomize()
	
#	var roll = randi() % 7 + 1
	var roll = 6 #for testing
	$roller/label.text = str(roll)
	outcome_effect(roll)
	
	print(roll)
	player.avail_moves = roll
	
	emit_signal("moves_left", roll)

func outcome_effect(roll):
	match roll:
		1: outcome = "worm"
		2: outcome = "none"
		3: outcome = "mole"
		4: outcome = "lvlu"
		5: outcome = "wulf"
		6: outcome = "gobk"
		7: outcome = "artf"
	
	player.outcome = outcome

func enable_rolling():
	$roller.modulate = Color("#ffffff")
	$roller.visible = true
	$roll_btn.visible = true
	$roll_btn.disabled = false
	pass

func _on_roll_btn_button_down():
	$roll_btn/label.anchor_top = 0.5
	pass # Replace with function body.

func _on_roll_btn_button_up():
	$roll_btn/label.anchor_bottom = 0.4
	pass # Replace with function body.


func _on_roll_btn_pressed():
	var lines = get_parent().get_parent().get_node("lines")
	lines.add_point(player.global_position)
	
	player.get_move_pos()
	
	$roll_btn.disabled = true
	$roll_btn.visible = false
	$roller.visible = true
	
	randomize_roll()
	pass # Replace with function body.


func _on_anim_animation_finished(anim_name):
	if anim_name == "pop":
		$anim.play("roller_fade")
	pass # Replace with function body.
