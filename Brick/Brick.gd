extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.9

func _ready():
	randomize()
	position = new_position
	position.x = new_position.x
	position.y = -100
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", new_position, 0.5 + randf()*2).set_trans(Tween.TRANS_ELASTIC)
	if score >= 100:
		$ColorRect.color = Color8(224,49,49)
	elif score >= 90:
		$ColorRect.color = Color8(255,146,43)
	elif score >= 80:
		$ColorRect.color = Color8(255,212,59)
	elif score >= 70:
		$ColorRect.color = Color8(148,216,45)
	elif score >= 60:
		$ColorRect.color = Color8(34,139,230)
	elif score >= 50:
		$ColorRect.color = Color8(132,94,247)
	elif score >= 40:
		$ColorRect.color = Color8(190,75,219)
	else:
		$ColorRect.color = Color8(134,142,150)



func _physics_process(_delta):
	if dying:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(position.x + randi_range(-1152,1152),-2000), 1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)	
		tween.tween_property(self, "rotation", randi_range(1,89), .8).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN)
		tween.tween_property($ColorRect, "modulate:a",0,.3).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN)
		
		
func hit(_ball): 	
	$On_Hit_Effect.color = Color8(randi_range(0,255),randi_range(0,255),randi_range(0,255),255)
	$On_Hit_Effect.emitting = true
	$AudioStreamPlayer2D.play()
	die()

	
func die():
	collision_layer = 0
	Global.update_score(score)
	dying = true
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instantiate()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)

