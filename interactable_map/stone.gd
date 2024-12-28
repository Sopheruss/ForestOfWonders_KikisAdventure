extends StaticBody2D

@onready var interaction_area = $InteractionArea  # Reference to the interaction area
@onready var sprite = $sprite  # Reference to the tree's Sprite2D
@onready var collision_shape = $CollisionShape  # Reference to the collision shape


func _ready() -> void:
	interaction_area.interact = Callable(self, "_sample_Stone")  # Register the interact callback

func _sample_Stone():
	sprite.hide()  # Hide the tree's visual sprite
	collision_shape.disabled = true  # Disable the collision shape
	interaction_area.queue_free()  # Optionally remove the interaction area
	#singleton einfügen
	var inventory_bar = get_tree().root.get_node("")
	inventory_bar.add_item(sprite.texture)
