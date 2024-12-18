extends CharacterBody2D

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
