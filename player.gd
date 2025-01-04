extends CharacterBody2D

class_name Player # defines class name, that can be used in other scenes? 

signal energyChanged # to signal change for EnergyBar

@export var maxHealth = 100 
@onready var currentHealth: int = maxHealth # currentHealth starts same as maxHealth 

@export var speed = 100
var screen_size 

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk_right")
		velocity.x += 1
		if Input.is_action_pressed("down"):
			velocity.y += 1
		else: if Input.is_action_pressed("up"):
				velocity.y -= 1
	else: if Input.is_action_pressed("left"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk_right")
		velocity.x -= 1
		if Input.is_action_pressed("down"):
			velocity.y += 1
		else: if Input.is_action_pressed("up"):
				velocity.y -= 1
	else: if Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("walk_front")
		velocity.y += 1
	else: if Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("walk_back")
		velocity.y -= 1
		
	if velocity.length() > 0: 
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else: 
		$AnimatedSprite2D.play("idles_front")
		
	position += velocity * delta 
	
	velocity = move_and_slide()

func pickUpStuffRemoveEnegry():
	#TODO: add method when stuff picked up and energy must change
	# Dont understand where to put funtion and how to connect Function of Player to e.g. Treee
	
	currentHealth -= 1 # sets how much energy is used 
	
	if currentHealth < 0: # check if energy is empty
		print("healthEmpty") #TODO: change what happens if Energy is empty
		
	energyChanged.emit() # signals progressBar in Main, that Energy changed and percentage must be changed
