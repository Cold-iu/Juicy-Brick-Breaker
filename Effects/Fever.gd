extends Node2D

func start_fever():
	fever()
	$Timer.start()



func end_fever():
	pass

func _on_Timer_timeout():
	if Global.feverish:
		fever()
		$Timer.start()
		var fever_score = get_node_or_null("/root/Game/Fever_Score")
		if fever_score != null:
			fever_score.playing = true
		var bg_music = get_node_or_null("/root/Game/bg_score")
		if bg_music != null:
			bg_music.playing = false
			
			
	else:
		end_fever()
		var fever_score = get_node_or_null("/root/Game/Fever_Score")
		if fever_score != null:
			fever_score.playing = false
		var bg_music = get_node_or_null("/root/Game/bg_score")
		if bg_music != null:
			bg_music.playing = true
		
			

		
		

func fever():
	var ball_container = get_node_or_null("/root/Game/Ball_Container")
	if ball_container != null:
		ball_container.make_ball_fever()
