extends Node

@onready var audio_player = $backgroundMusik

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
