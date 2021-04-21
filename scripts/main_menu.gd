extends Control

func _ready():
	pass


func _on_play_btn_pressed():
	get_tree().change_scene("res://scenes/test.tscn")
	pass # Replace with function body.


func _on_play_btn_button_down():
	$click.play()
	pass # Replace with function body.
