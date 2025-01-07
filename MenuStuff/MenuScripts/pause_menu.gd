extends Control

@onready var muteButton = get_node("PanelContainer/MarginContainer/VBoxContainer/MuteButton")

var sound = false
var bus_idx = AudioServer.get_bus_index("Master")

func _ready(): 
	$AnimationPlayer.play("RESET")

func resume(): 
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause(): 
	show() # make pause menu visible
	get_tree().paused = true
	$AnimationPlayer.play("blur")

# checks if esc is pressed -> if so startes PauseMenu
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

func _on_quit_pressed() -> void:
	if get_tree().paused == false: 
		pass 
	else: 
		get_tree().quit()

# checks continous if esc is pressed 
func _process(_delta):
	testEsc()


func _on_mute_button_pressed() -> void:
	if sound:
		muteButton.text = "Sound: ON"
		AudioServer.set_bus_mute(bus_idx, false)
		sound = false
	else: 
		muteButton.text = "Sound: OFF"
		AudioServer.set_bus_mute(bus_idx, true)
		sound = true
