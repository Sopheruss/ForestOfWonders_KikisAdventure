extends HBoxContainer

@export var slot_scene: PackedScene

var inventory = [] #Liste für alle slots
var slots = {} #Referenz zu slot-nodes

func create_slots(count):
	# Lösche bestehende Slots
	for i in inventory:
		var slot = slot_scene.new()
		$HBoxContainer.add_child(slot)
		slots.append(slot)
		
func add_item(texture: Texture):
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
	create_slots(5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
