extends CharacterBody2D

## Energy Conditions: 
## 
## Speed is Depending on Energy
##		if Energy is below 10 speed is 50% reduced
## if Energy is 0 
##		movement stops
##		TODO: Interaction denied 
##		player poofs and faints (TODO: until energy is above 5)
## On interaction: 
##		Energy is reduced (in each item interaction)
##		stone and tree: -10 Energy
##		special item: -5 Energy
## Every 1 second player gets back 1 Energy (clamped to maxEnergy)

signal energyChanged # to signal change for EnergyBar
signal animation_looped

@export var maxEnergy = 100 # defines maxHealth shown in EnergyBar
@onready var currentEnergy: int = maxEnergy # currentHealth starts same as maxHealth 

@export var speed = 100
@onready var audio_player = $AudioStreamPlayer

@onready var regainEnergyTimer = $Add1EnergyEveryXSec

var screen_size
var is_moving = false # Tracks if the player is currently moving
var poof_played = false # Tracks if poof was played after 0 energy

func setCurrentEnergy(value: int):
	currentEnergy = value

func getCurrentEnergy():
	return currentEnergy

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	energyChanged.emit() # emits signal to energyBar if energy changed -> calls update
	
	if currentEnergy <= 0: # check if energy is empty
		playPoofAndFaintAnim()
		return # stops movement and walk/idle animation if energy is empty
	
	speedDependingOnEnergy()
	
	movement(delta, speed) # handles movement (outsourced in method for better readability of process)


func movement(delta, speed):
	var velocity = Vector2.ZERO # The player's movement vector.
	
	# Movement logic
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk_right")
		velocity.x += 1
		if Input.is_action_pressed("down"):
			velocity.y += 1
		elif Input.is_action_pressed("up"):
			velocity.y -= 1
	elif Input.is_action_pressed("left"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk_right")
		velocity.x -= 1
		if Input.is_action_pressed("down"):
			velocity.y += 1
		elif Input.is_action_pressed("up"):
			velocity.y -= 1
	elif Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("walk_front")
		velocity.y += 1
	elif Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("walk_back")
		velocity.y -= 1
		
	# Check movement and play/stop sound
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if not is_moving: # Start sound if not already moving
			audio_player.play()
			is_moving = true
	else:
		if is_moving: # Stop sound if the player stops
			audio_player.stop()
			is_moving = false
		$AnimatedSprite2D.play("idles_front")
	
	position += velocity * delta
	velocity = move_and_slide()


func playPoofAndFaintAnim():
	# after poof animation played, signal is emitted 
	# signal executes function _on_animated_sprite_2d_animation_finished()
	# changes poof played to true 
	# and faint animation starts playing
	
	if poof_played == false:
		$AnimatedSprite2D.play("poof")
		emit_signal("animation_finished", "poof")
	else:
		$AnimatedSprite2D.play("fainted")


func speedDependingOnEnergy():
	if currentEnergy <= 10: # if Energy is <= 10 speed is reduced!
		speed = 50
	else:
		speed = 100

func _on_add_1_energy_every_x_sec_timeout() -> void:
	if currentEnergy <= 0: 
		await get_tree().create_timer(5.0).timeout
		poof_played = false
		
	currentEnergy += 1
	currentEnergy = clamp(currentEnergy, 0, maxEnergy) # value clamped so that it does not go beyond 100


func _on_animated_sprite_2d_animation_looped() -> void:
	print("poof looped")
	poof_played = true
