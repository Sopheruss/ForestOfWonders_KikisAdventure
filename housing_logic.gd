extends Node2D

@export var tent: Texture
@export var house: Texture

@onready var currentHousing = $HouseOrTent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentHousing.texture = house


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
