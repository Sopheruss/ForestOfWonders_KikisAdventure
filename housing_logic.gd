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


func check_requests(inventory: Array):
		is_ready_to_build_house = get_state(inventory)

func get_state(inventory: Array):
	var i = 0
	for item in inventory:
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
	if (i == inventory.size()):
		return true
	return false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	housing.texture = tent
	
	slots = [
		$Speechbubble/Conditions/Condition0,
		$Speechbubble/Conditions/Condition1,
		$Speechbubble/Conditions/Condition2,
		$Speechbubble/Conditions/Condition3,
		$Speechbubble/Conditions/Condition4
		]
	requirements = {
		special_item: 4,
		stone: 20,
		tree_bluegreen: 20,
		tree_lightgreen: 20,
		tree_orange: 20
	}
	var i = 0
	for requirement in requirements:
		slots[i].update_item(requirement, requirements[requirement])
		i = i + 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_ready_to_build_house):
		#housing.texture = house
		if($Speechbubble.visible):
			$Speechbubble.visible = false
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
