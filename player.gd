extends CharacterBody2D

class_name Player # defines class name, that can be used in other scenes? 

signal energyChanged # to signal change for EnergyBar

@export var maxHealth = 100 
@onready var currentHealth: int = maxHealth # currentHealth starts same as maxHealth 

@export var speed = 100
@onready var audio_player = $AudioStreamPlayer
@onready var currentAnimation = "idles_down"
@onready var lastPressed: String
var screen_size
var is_moving = false # Tracks if the player is currently moving


func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
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

func pickUpStuffRemoveEnegry():
	#TODO: add method when stuff picked up and energy must change
	# Dont understand where to put funtion and how to connect Function of Player to e.g. Treee
	
	currentHealth -= 1 # sets how much energy is used 
	
	if currentHealth < 0: # check if energy is empty
		print("healthEmpty") #TODO: change what happens if Energy is empty
		
	energyChanged.emit() # signals progressBar in Main, that Energy changed and percentage must be changed

func playMagicAnimation():
	currentAnimation = "magic_" + lastPressed
	await get_tree().create_timer(0.5).timeout
	currentAnimation = "idles_" + lastPressed
