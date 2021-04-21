extends TextureRect

signal atk_finished

var icon = "res://sprites/player_icon.png"

var turn_order_card

var health
var attack
var defense
var speed

func _ready():
	set_player_stats()
	
	connect("atk_finished", get_parent().get_node("panel/hbox/turn_order"), "next_battler")
	pass

func set_player_stats():
	var p = get_parent().get_parent().get_parent().get_node("player/stats")
	
	health = p.health
	attack = p.attack
	defense = p.defense
	speed = p.speed
	
	$health.text = str(health)
	$attack.text = str(attack)
	$defense.text = str(defense)
	$speed.text = str(speed)

func update_hp():
	$health.text = str(health)

func attack():
	var target = get_parent().get_node("panel/hbox/details/point").target
	
	$anim.play("attack")
	target.hurt(attack)
	pass

func hurt(damage):
	$hurt.play()
	
	damage -= defense #mitigate damage
	if damage <= 0:
		damage = 0
	health -= damage #deal damage
	update_hp()
	
	$anim.play("hurt")


func _on_anim_animation_finished(anim_name):
	if anim_name == "attack":
		emit_signal("atk_finished")
	if anim_name == "hurt":
		if health <= 0:
			health = 0
			get_parent().get_node("panel/battle").disabled = true
			if is_instance_valid(turn_order_card) == true:
				turn_order_card.queue_free()
			
			update_hp()
			$anim.play("dead")
	pass # Replace with function body.




