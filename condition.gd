extends Panel

#Item Data
var item_texture: Texture = null
var item_count: int = 0

func update_item(texture: Texture, count: int):
	item_texture = texture
	item_count = count
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (item_count > 0):
		$Count.text = str(item_count) + " x"
		$Item_Texture.texture = item_texture
	else:
		$Count.text = ""
		$Item_Texture.texture = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (item_count > 0):
		$Count.text = str(item_count) + " x"
		$Item_Texture.texture = item_texture
	else:
		$Count.text = ""
		$Item_Texture.texture = null
