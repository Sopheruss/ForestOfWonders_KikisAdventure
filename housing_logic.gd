extends StaticBody2D

@export var tent: Texture
@export var house: Texture

@export var special_item: Texture
@export var stone: Texture
@export var tree_bluegreen: Texture
@export var tree_lightgreen: Texture
@export var tree_orange: Texture

@onready var housing = $Texture
@onready var is_ready_to_build_house = false

@onready var requirements = {}
@onready var slots = []

@onready var YouDidIt = get_tree().root.get_node("game").get_node("HUD").get_node("YouDidIt!")


func check_requests(inventory: Array):
		is_ready_to_build_house = get_state(inventory)

func get_state(inventory: Array):
	# stays false because house is already changed
	if (housing.texture == house):
		return false
	
	var i = 0
	for item in inventory:
		# stops when the slot is empty
		if(item.get_itemTexture() == null):
				return false
		for slot in slots:
			#find matching texture
			if(item.get_itemTexture() == slot.get_texture()):
				#compares count
				if(item.get_count() >= slot.get_count()):
					slot.set_check()
					item.change_texture()
					i+=1
	# so all requirements are matched
	if (i == inventory.size()):
		return true
	return false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	housing.texture = tent
	
	YouDidIt.hide()
	
	slots = [
		$Speechbubble/Conditions/Condition0,
		$Speechbubble/Conditions/Condition1,
		$Speechbubble/Conditions/Condition2,
		$Speechbubble/Conditions/Condition3,
		$Speechbubble/Conditions/Condition4
		]
	requirements = {
		special_item: 1,
		stone: 1,
		tree_bluegreen: 1,
		tree_lightgreen: 1,
		tree_orange: 1
	}
	var i = 0
	for requirement in requirements:
		slots[i].update_item(requirement, requirements[requirement])
		i = i + 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_ready_to_build_house):
		if($Speechbubble.visible):
			$Speechbubble.visible = false
			$SpeechBubbleCollision.disabled = true
		if(!$Upgrade.visible):
			$Upgrade.visible = true


func _on_upgrade_pressed() -> void:
	$PoufAnimation.visible = true
	$PoufAnimation.play("pouf")
	await get_tree().create_timer(0.8).timeout
	housing.texture = house
	is_ready_to_build_house = false
	$Upgrade.visible = false
	$PoufAnimation.visible = false
	await get_tree().create_timer(2.0).timeout
	YouDidIt.show()
	await get_tree().create_timer(2.5).timeout
	YouDidIt.hide()
	
