extends StaticBody2D

@onready var interaction_area = $InteractionArea  # Reference to the interaction area
@onready var sprite = $sprite  # Reference to the tree's Sprite2D
@onready var collision_shape = $CollisionShape  # Reference to the collision shape
@onready var audio_player = $AudioStreamPlayer # Reference to audio stream
@onready var inventory_bar = get_tree().root.get_node("game").get_node("HUD").get_node("InventoryBar")
@onready var energy_bar = get_tree().root.get_node("game").get_node("HUD").get_node("EnergyBar")

var special_item_energy_usage = -5

func _ready() -> void:
	interaction_area.interact = Callable(self, "_sample_Special")  # Register the interact callback
	

func _sample_Special():
	sprite.hide()  # Hide the tree's visual sprite
	collision_shape.disabled = true  # Disable the collision shape
	audio_player.play()
	interaction_area.queue_free()  # Optionally remove the interaction area
	inventory_bar.add_item(sprite.texture)
	energy_bar.handleEnergyChange(special_item_energy_usage) # removes 5 energy
