extends HBoxContainer

@export var slot_scene: PackedScene

var slots = {} #Referenz zu slot-nodes
		
func add_item(texture: Texture):
	#signal hinzufügen um slots zu informieren, was sie machen sollen
	if slots.has(texture):
		var counter = slots.get(texture)
		counter = counter+1;
		slots[texture] = counter
		print(counter)
	else:
		slots[texture] = 1
		print("new")
	
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
