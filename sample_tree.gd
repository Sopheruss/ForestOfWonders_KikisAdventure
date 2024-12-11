extends StaticBody2D

@onready var interaction_area = $InteractionArea # reference

func _ready() -> void:
	interaction_area.interact = Callable(self, "_sample_Tree")

func _sample_Tree():
	print ("interaction")
