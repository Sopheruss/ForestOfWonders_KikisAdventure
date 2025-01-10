extends StaticBody2D

@onready var interaction_area = $InteractionArea  # Reference to the interaction area
@onready var sprite = $sprite  # Reference to the tree's Sprite2D
@onready var collision_shape = $CollisionShape  # Reference to the collision shape
@onready var audio_player = $AudioStreamPlayer # Reference to audio stream
@onready var inventory_bar = get_tree().root.get_node("game").get_node("HUD").get_node("InventoryBar")
@onready var energy_bar = get_tree().root.get_node("game").get_node("HUD").get_node("EnergyBar")

var special_item_energy_usage = -5

@onready var player = get_tree().root.get_node("game").get_node("Player")

@onready var backgroundMusic = get_tree().root.get_node("game").get_node("backgroundMusik")
@onready var playSpecialeffekts = true

func _ready() -> void:
	interaction_area.interact = Callable(self, "_sample_Special")  # Register the interact callback

func _process(delta: float) -> void:
	playSpecialeffekts = get_tree().root.get_node("game").get_node("HUD").get_node("PauseMenu").soundEffects

func _sample_Special():
	sprite.hide()  # Hide the tree's visual sprite
	player.playMagicAnimation()
	collision_shape.disabled = true  # Disable the collision shape
	
	if not playSpecialeffekts:
		backgroundMusic.stop()
	
	audio_player.play()
	interaction_area.queue_free()  # Optionally remove the interaction area
	inventory_bar.add_item(sprite.texture)
	energy_bar.handleEnergyChange(special_item_energy_usage) # removes 5 energy
	
	if not playSpecialeffekts:
		await get_tree().create_timer(5.0).timeout
		backgroundMusic.play()
