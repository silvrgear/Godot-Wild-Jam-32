extends Area2D

onready var confirm_move_pop = preload("res://entities/confirm_move.tscn")
onready var plot_details = preload("res://entities/plot_details.tscn")
onready var canvas = get_node("/root").get_child(0).get_node("canvas")

var n_move = 0
var e_move = 0
var w_move = 0
var s_move = 0

var curr_plot
var outcome

var move_history = [] #n, e, w, s
var pos_history = []
var avail_moves = 0

func _ready():
	pass

func _input(event):
	if avail_moves >= 1:
		if event.is_action_pressed("up"):
			if move_history.empty() == false:
				if move_history.back() == "n":
					position.y -= pos_history.back()
					back_move()
					return
			
			position.y -= n_move #lerp movement
			$facing/sprite.frame = 1
			
			if n_move == 0:
				print("can't go there") #play error sfx
				return
			
			move("s", n_move)
		if event.is_action_pressed("down"):
			if move_history.empty() == false:
				if move_history.back() == "s":
					position.y += pos_history.back()
					back_move()
					return
			
			position.y += s_move
			$facing/sprite.frame = 0
			
			if s_move == 0:
				return
			
			move("n", s_move)
		if event.is_action_pressed("left"):
			if move_history.empty() == false:
				if move_history.back() == "w":
					position.x -= pos_history.back()
					back_move()
					return
			
			position.x -= w_move
			$facing/sprite.frame = 0
			
			if w_move == 0:
				return
			
			move("e", w_move)
		if event.is_action_pressed("right"):
			if move_history.empty() == false:
				if move_history.back() == "e":
					position.x += pos_history.back()
					back_move()
					return
			
			position.x += e_move
			$facing/sprite.frame = 1
			
			if e_move == 0:
				return
			
			move("w", e_move)

func get_move_pos():
	get_overlapping_areas()
	var p = get_overlapping_areas()
	var plot = p[0]
	
	curr_plot = plot
	
	n_move = plot.north
	e_move = plot.east
	w_move = plot.west
	s_move = plot.south
	pass

func move(last_dir, pos):
	avail_moves -= 1
	move_history.append(last_dir)
	pos_history.append(pos)
	
	#update ui
	canvas.get_node("avail_moves").update_moves(avail_moves)
	
	print(move_history)
	if avail_moves == 0:
		#show current monsters
		var pdetails = plot_details.instance()
#		pdetails.set_details(curr_plot.monsters)
		pdetails.outcome = outcome
		canvas.add_child(pdetails)
		
		var cmove = confirm_move_pop.instance()
		canvas.add_child(cmove)
	
	#create lines
	var lines = get_parent().get_node("lines")
	lines.add_point(global_position)

func back_move():
	avail_moves += 1
	move_history.pop_back()
	pos_history.pop_back()
	
	#update ui
	canvas.get_node("avail_moves").update_moves(avail_moves)
	
	print(move_history)
	
	#revert lines
	var lines = get_parent().get_node("lines")
	lines.remove_point(lines.get_point_count() - 1)
	pass

func return_to_orig_position():
	avail_moves += 1
	match move_history.back():
		"n": position.y -= pos_history.back()
		"e": position.x += pos_history.back()
		"w": position.x -= pos_history.back()
		"s": position.y += pos_history.back()
	move_history.pop_back()
	pos_history.pop_back()
	
	#update_ui
	canvas.get_node("avail_moves").update_moves(avail_moves)
	
	#revert lines
	var lines = get_parent().get_node("lines")
	lines.remove_point(lines.get_point_count() - 1)
	pass

func _on_player_area_entered(area):
	curr_plot = area
	
	n_move = area.north
	e_move = area.east
	w_move = area.west
	s_move = area.south
	pass # Replace with function body.






