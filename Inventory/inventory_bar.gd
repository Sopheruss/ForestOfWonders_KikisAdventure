extends HBoxContainer

var slots = []
		
func add_item(texture: Texture):
	for slot in slots:
		if slot.get_itemTexture() == texture:
			slot.update_count()
			break
		else: if slot.get_count() == 0:
			slot.update_item(texture,1)
			break
		
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slots = [
		$InventorySlot0,
		$InventorySlot1,
		$InventorySlot2,
		$InventorySlot3,
		$InventorySlot4,
		$InventorySlot5
		]
	for slot in slots:
		print(slot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
