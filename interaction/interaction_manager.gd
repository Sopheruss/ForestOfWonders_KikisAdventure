extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text = "[E] to "

var active_areas = [] # hold all interaction areas
var closest_area = null  # Stores the closest interactable area
var can_interact = true

const MAX_INTERACTION_DISTANCE = 30.0 * 30.0  # maximum interaction range (Sqrt)

func register_area(area: InteractionArea):
	if not active_areas.has(area):
		active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	active_areas.erase(area)


func _ready():
	get_tree().node_added.connect(func(_node):
		player = get_tree().get_first_node_in_group("player")
	)

# Continuously check for closest area and update the label position
func _process(delta):
	closest_area = null  # Reset the closest area for this frame
	
	if active_areas.size() > 0:
		# Check each area and find the closest one within range
		for area in active_areas:
			var distance_to_player = player.global_position.distance_squared_to(area.global_position)
			if distance_to_player <= MAX_INTERACTION_DISTANCE:
				if closest_area == null or distance_to_player < player.global_position.distance_squared_to(closest_area.global_position):
					closest_area = area
		
		# Show label if a closest area was found
		if closest_area:
			label.text = base_text + closest_area.action_name
			label.global_position = closest_area.global_position
			label.global_position.y -= (150 * label.scale.y)  # Adjust Y position with scale
			var text_rect = label.get_rect()
			label.global_position.x -= (text_rect.size.x * label.scale.x + 50) / 2  # Center horizontally with scale
			label.show()
		else:
			label.hide()
	else:
		label.hide()

func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if closest_area:
			can_interact = false
			label.hide()
			
			# Call the interact function
			await closest_area.interact.call()
			
			can_interact = true
