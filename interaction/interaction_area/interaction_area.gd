extends Area2D
class_name InteractionArea

@export var action_name: String = "interact" # text above object

var interact: Callable = func(): # kann überschrieben werden
	pass
	

func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
