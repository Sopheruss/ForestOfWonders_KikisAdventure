extends StaticBody2D

@onready var interaction_area = $InteractionArea # reference
@onready var animation = $Animation # reference
@onready var player = get_tree().root.get_node("game").get_node("Player")
var is_anim_playing = false  # To track the animation state

func _ready() -> void:
	interaction_area.interact = Callable(self, "_toggle_animation")

func _toggle_animation():
	player.playMagicAnimation()
	if is_anim_playing:
		# Stop the animation
		animation.stop()
		is_anim_playing = false
	else:
		# Play the animation (replace 'fire' with your actual animation name)
		animation.play("campfire")
		is_anim_playing = true
