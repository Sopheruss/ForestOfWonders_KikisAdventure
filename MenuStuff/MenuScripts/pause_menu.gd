extends Control

func _ready(): 
	$AnimationPlayer.play("RESET")

func resume(): 
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause(): 
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	if get_tree().paused == false: 
		pass 
	else: 
		resume()

func _on_options_pressed() -> void:
	if get_tree().paused == false: 
		pass 
	else: 
		pass #needs to change acoordingly -> open options menu 

func _on_quit_pressed() -> void:
	if get_tree().paused == false: 
		pass 
	else: 
		get_tree().quit()

func _process(_delta):
	testEsc()
