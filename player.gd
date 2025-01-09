extends CharacterBody2D

## Energy Conditions: 
## Speed is Depending on Energy
##		if Energy is below 10 speed is 50% reduced
## if Energy is 0 
##		movement stops
##		movement sound stops
##		TODO: Interaction denied 
##		player faints, has to wait 5 sec befor moving again
## On interaction: 
##		Energy is reduced (in each item interaction)
##		stone and tree: -10 Energy
##		special item: -5 Energy
## Every 1 second player gets back 1 Energy (clamped to maxEnergy)

signal energyChanged # to signal change for EnergyBar

@export var maxEnergy = 100 # defines maxHealth shown in EnergyBar
@onready var currentEnergy: int = maxEnergy # currentHealth starts same as maxHealth 

@export var speed = 100
@onready var audio_player = $AudioStreamPlayer
@onready var audio_player2 = $AudioStreamPlayer2 # Reference to audio stream (snoring)

@onready var currentAnimation = "idles_down"
@onready var lastPressed: String

@onready var regainEnergyTimer = $Add1EnergyEveryXSec

var screen_size
var is_moving = false # Tracks if the player is currently moving

func setCurrentEnergy(value: int):
	currentEnergy = value

func getCurrentEnergy():
	return currentEnergy

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	energyChanged.emit() # emits signal to energyBar if energy changed -> calls update
	
	if currentEnergy <= 0: # check if energy is empty
		audio_player.stop() #stops footstepsounds, if fainted
		playFaintAnim()
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
		lastPressed = "right"
	elif Input.is_action_pressed("left"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk_right")
		velocity.x -= 1
		if Input.is_action_pressed("down"):
			velocity.y += 1
		elif Input.is_action_pressed("up"):
			velocity.y -= 1
		lastPressed = "right"
	elif Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("walk_down")
		velocity.y += 1
		lastPressed = "down"
	elif Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("walk_up")
		velocity.y -= 1
		lastPressed = "up"

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
			currentAnimation = "idles_" + lastPressed
		$AnimatedSprite2D.play(currentAnimation)
	
	position += velocity * delta
	velocity = move_and_slide()


func playFaintAnim():
	# faint animation starts playing
	$AnimatedSprite2D.play("fainted")


func speedDependingOnEnergy():
	if currentEnergy <= 10: # if Energy is <= 10 speed is reduced!
		$EnergyLowLabel.show() # shows warning label of low energy
		speed = 50
	else:
		$EnergyLowLabel.hide() # hides low energy label
		speed = 100

var isTimerActive = false

func _on_add_1_energy_every_x_sec_timeout() -> void:
	if currentEnergy <= 0: 
		$EnergyLowLabel.hide() # hides label if unconscious 
		if not isTimerActive: 
			isTimerActive = true
			if not audio_player2.is_playing():
				audio_player2.play()
			
			await get_tree().create_timer(5.0).timeout
			isTimerActive = false
			audio_player2.stop() # Check again after the timer
			
			if currentEnergy <= 0: 
				currentEnergy += 1
		
		else:
			pass
	else:
		currentEnergy += 1
		currentEnergy = clamp(currentEnergy, 0, maxEnergy) # value clamped so that it does not go beyond maxEnergy

func playMagicAnimation():
	currentAnimation = "magic_" + lastPressed
	await get_tree().create_timer(0.5).timeout
	currentAnimation = "idles_" + lastPressed
