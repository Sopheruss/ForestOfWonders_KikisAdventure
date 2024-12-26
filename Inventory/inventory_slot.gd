extends TextureRect

#Item Data
var item_texture: Texture = null
var item_count: int = 0

#Child-Nodes
@onready var texture_rec = $Item
@onready var count_label = $Anzahl

func set_item(texture: Texture, count: int):
	item_texture = texture
	item_count = count
	update_slot()
	
func update_slot():
	if item_texture:
		texture_rec.texture = item_texture
		texture_rec.visible = true
	else:
		texture_rec.visible = false
	count_label.text = str(item_count) if item_count > 1 else ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
