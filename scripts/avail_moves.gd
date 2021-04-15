extends Label



func _ready():
	pass

func update_moves(moves):
	$moves.text = str(moves)
	pass

func _on_roll_btn_moves_left(roll):
	$moves.text = str(roll)
	$anim.play("pop")
	pass # Replace with function body.
