extends TextureRect

#Item Data
var item_texture: Texture = null
var item_count: int = 0
@export var checkedTexture: Texture


func update_item(texture: Texture, count: int):
	item_texture = texture
	item_count = count

func change_texture():
	if(texture != checkedTexture):
		texture = checkedTexture

func get_count():
	return item_count

func get_itemTexture():
	return item_texture

func update_count():
	item_count += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (item_count > 0):
		$Anzahl.text = str(item_count)
		$Item.texture = item_texture
	else:
		$Anzahl.text = ""
		$Item.texture = null
