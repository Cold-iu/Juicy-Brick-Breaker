extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.1

func _ready():
	randomize()
	position = new_position
	position.x = new_position.x
	position.y = -100
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", new_position, 0.5 + randf()*2).set_trans(Tween.TRANS_ELASTIC)



func _physics_process(_delta):
	if dying:
		queue_free()
		
		
func hit(_ball): 	
	$On_Hit_Effect.color = Color8(randi_range(0,255),randi_range(0,255),randi_range(0,255),255)
	$On_Hit_Effect.emitting = true
	
	
	die()

func die():
	dying = true
	collision_layer = 0
	Global.update_score(score)
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
			

