extends CharacterBody2D

signal energyChanged # to signal change for EnergyBar

@export var maxHealth = 100 # defines maxHealth shown in EnergyBar
@onready var currentHealth: int = maxHealth # currentHealth starts same as maxHealth 
@onready var energyBar = get_tree().root.get_node("game").get_node("HUD").get_node("EnergyBar")

@export var speed = 100
@onready var audio_player = $AudioStreamPlayer
var screen_size
var is_moving = false # Tracks if the player is currently moving
var poof_played = false

func setCurrentHealth(value: int):
	currentHealth = value

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	energyChanged.emit() # emits signal to energyBar if energy changed -> calls update
	
	if currentHealth <= 0: # check if energy is empty
		
		$AnimatedSprite2D.play("fainted")
		return # stops movement and animation if energy is empty
	
	movement(delta)


func movement(delta):
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
