extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text = "[E] to "

var active_areas = [] # hold all interaction areas
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index) 


func _ready():
	get_tree().node_added.connect(func(_node):
		player = get_tree().get_first_node_in_group("player")
	)

func _process(delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		# get scaled size of label
		var text_rect = label.get_rect()
		var scaled_width = text_rect.size.x * label.scale.x
		var scaled_height = text_rect.size.y * label.scale.y
		
		label.global_position = active_areas[0].global_position
		#label.global_position.y -= 150
		#label.global_position.x -= label.get_rect().size.x / 2
		
		label.global_position.y -= (150 * label.scale.y)  # Adjust Y position with scale
		label.global_position.x -= (scaled_width + 50 / 2)  # Center horizontally with scale
		label.show()
	else: 
		label.hide()
		
func _sort_by_distance_to_player(area1,area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return  area1_to_player < area2_to_player


func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call() # .call() to call our callabale like a function
			
			can_interact = true
