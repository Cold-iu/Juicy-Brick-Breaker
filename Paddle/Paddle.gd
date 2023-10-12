extends CharacterBody2D

var target = Vector2.ZERO
var speed = 10.0
var width = 0
var width_default = 0
var decay = 0.02
var new_pos = Vector2.ZERO

var tween

func _ready():
	width = $CollisionShape2D.get_shape().size.x
	width_default = width
	target = Vector2(Global.VP.x / 2, Global.VP.y - 80)

func _physics_process(_delta):
	target.x = clamp(target.x, width/2, Global.VP.x - width/2)
	position = target
	for c in $Powerups.get_children():
		c.payload()

func _input(event):
	if event is InputEventMouseMotion:
		target.x += event.relative.x
		
func bounce_reset(body):
	body.bounce_reset()
	
	

func hit(_ball):
	var tween = get_tree().create_tween()
	$On_Hit_Effect.color = Color8(randi_range(0,255),randi_range(0,255),randi_range(0,255),255)
	$On_Hit_Effect.emitting = true
	$Outline.visible = true
	tween.tween_property($Outline,"scale",1.5,1)
	tween.tween_property($Outline,"visible",false,.5)
	

	
	tween.tween_property($Outline,"modulate",Color8(randi_range(0,255),randi_range(0,255),randi_range(0,255),255),.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

	

func powerup(payload):
	for c in $Powerups.get_children():
		if c.type == payload.type:
			c.queue_free()
	$Powerups.call_deferred("add_child", payload)
