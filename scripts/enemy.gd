extends Control

signal selected(enemy)
signal atk_finished
signal pass_exp(exp_amount)

var turn_order

var health = 0
var attack = 0
var defense = 0
var speed = 0
var exp_give = 0

var icon

var target
var turn_order_card

func _ready():
	turn_order = get_parent().get_parent().get_parent().get_node("turn_order")
	
	connect("pass_exp", get_parent().get_parent().get_parent().get_parent().get_parent(), "take_exp_from_kills")
	connect("selected", get_parent().get_parent().get_node("point"), "target_change")
	connect("atk_finished", turn_order, "next_battler")
	pass

func update_stats(hp, atk, def, spd, expg):
	health = hp
	attack = atk
	defense = def
	speed = spd
	exp_give = expg
	
	$tex/health.text = str(hp)
	$tex/attack.text = str(atk)
	$tex/defense.text = str(def)
	$tex/speed.text = str(spd)

func update_hp():
	$tex/health.text = str(health)

func attack():
	var target = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("dummy")
	
	$anim.play("attack")
	target.hurt(attack)
	pass

func hurt(damage):
	$hurt.play()
	damage -= defense #mitigate damage
	if damage <= 0:
		damage = 0
	print(damage)
	health -= damage #deal damage
	update_hp()
	
	$anim.play("hurt")


func _on_enemy1_gui_input(event):
	if get_parent().can_change_target == true:
		if event.is_action_pressed("click"):
			emit_signal("selected", self.get_index())
	pass # Replace with function body.


func _on_anim_animation_finished(anim_name):
	if anim_name == "attack":
		emit_signal("atk_finished")
	if anim_name == "hurt":
		if health <= 0:
			health = 0
			
			emit_signal("pass_exp", exp_give)
			
			if is_instance_valid(turn_order_card) == true:
				turn_order_card.queue_free()
			
			update_hp()
			$anim.play("dissolve")
	if anim_name == "dissolve":
		queue_free()
	pass # Replace with function body.






