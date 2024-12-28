extends TextureRect

#Item Data
var item_texture: Texture = null
var item_count: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (item_count > 0):
		$Anzahl.text = str(item_count) + " x"
		$Item.texture = item_texture
	else:
		$Anzahl.text = ""
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
