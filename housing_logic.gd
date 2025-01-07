extends Node2D

@export var tent: Texture
@export var house: Texture

@export var special_item: Texture
@export var stone: Texture
@export var tree_bluegreen: Texture
@export var tree_lightgreen: Texture
@export var tree_orange: Texture

@onready var currentHousing = $HouseOrTent
@onready var is_ready_to_build_house = false

@onready var requirements = {}
@onready var slots = []


func check_requests(inventory: Array):
	for requiremnet in requirements:
		for item in inventory:
			#means not all items are filled, so skip
			if(item.get_itemTexture() == null):
				return
			#find matching texture
			if(item.get_itemTexture() == requiremnet):
				#compares count
				if(item.get_count() >= requirements[requiremnet]):
					continue
				#no need to look further at this point
				else:
					return
	is_ready_to_build_house = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentHousing.texture = tent
	
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
		currentHousing.texture = house
