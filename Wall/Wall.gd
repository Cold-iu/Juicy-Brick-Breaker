extends StaticBody2D

var decay = 0.01

var tween

func _ready():
	pass

func _physics_process(_delta):
	pass

func hit(_ball):
	if tween:
		tween.kill()
	var tween = get_tree().create_tween()
	$ColorRect.visible = true
	$ColorRect.scale = Vector2(1.5,1.5)
	tween.tween_property($ColorRect,"color",Color8(randi_range(0,255),randi_range(0,255),randi_range(0,255),255),.75).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($ColorRect,"scale",Vector2(1,1),.75)
	tween.tween_property($ColorRect,"visible",false,.75).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT_IN)

	

