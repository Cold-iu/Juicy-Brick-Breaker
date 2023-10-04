extends RigidBody2D

var min_speed = 100.0
var max_speed = 600.0
var speed_multiplier = 1.0
var accelerate = false


var time_highlight = 0.4
var time_highlight_size = 0.3

var wobble_period = 0.0
var wobble_amplitude = 0.0
var wobble_max = 5
var wobble_direction = Vector2.ZERO
var decay_wobble = 0.15

var tween

var released = true

var initial_velocity = Vector2.ZERO

func _ready():
	contact_monitor = true
	max_contacts_reported = 8
	if Global.level < 0 or Global.level >= len(Levels.levels):
		Global.end_game(true)
	else:
		var level = Levels.levels[Global.level]
		min_speed *= level["multiplier"]
		max_speed *= level["multiplier"]
	

func _on_Ball_body_entered(body):
	if body.has_method("hit"):
		body.hit(self)
		accelerate = true
	if tween:
		tween.kill()
	tween = create_tween().set_parallel(true)
	tween.tween_property($Ball_Sprite, "modulate", Color8(randi_range(0,255),randi_range(0,255),randi_range(0,255),255), .3).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	$Aura.modulate = Color8(randi_range(0,255),randi_range(0,255),randi_range(0,255),255)
	tween.tween_property($Aura, "modulate:a", 0, time_highlight).set_trans(Tween.TRANS_LINEAR)
	
	$Aura.scale = Vector2(2.0,2.0)
	tween.tween_property($Aura, "scale", Vector2(1.0,1.0),time_highlight_size).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
	$Ball_Sprite.skew = 0
	tween.tween_property($Ball_Sprite,"skew",randi_range(0,30),randi_range(.2,2))
	tween.tween_property($Ball_Sprite,"Rotation",randi_range(0,45),2)
		
		
func _input(event):
	if not released and event.is_action_pressed("release"):
		apply_central_impulse(initial_velocity)
		released = true

func _integrate_forces(state):
	if not released:
		var paddle = get_node_or_null("/root/Game/Paddle_Container/Paddle")
		if paddle != null:
			state.transform.origin = Vector2(paddle.position.x, paddle.position.y - 30)	

	if position.y > Global.VP.y + 100:
		die()
	if accelerate:
		state.linear_velocity = state.linear_velocity * 1.1
		accelerate = false
	if abs(state.linear_velocity.x) < min_speed * speed_multiplier:
		state.linear_velocity.x = sign(state.linear_velocity.x) * min_speed * speed_multiplier
	if abs(state.linear_velocity.y) < min_speed * speed_multiplier:
		state.linear_velocity.y = sign(state.linear_velocity.y) * min_speed * speed_multiplier
	if state.linear_velocity.length() > max_speed * speed_multiplier:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed * speed_multiplier

func change_size(s):
	$ColorRect.scale = s
	$CollisionShape2D.scale = s

func change_speed(s):
	speed_multiplier = s

func die():
	queue_free()
