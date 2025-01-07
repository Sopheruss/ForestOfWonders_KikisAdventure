extends TextureProgressBar

@onready var player = get_tree().root.get_node("game").get_node("Player")
@onready var currentEnergy:int = player.maxEnergy

func _ready():
	# connected to player script so that update is called every time there is an Energy Change
	player.energyChanged.connect(update)

func _process(delta: float) -> void:
	currentEnergy = player.getCurrentEnergy()
	update()
	
func update(): 
	# value is shown as percentage of maxEnergy
	value = player.getCurrentEnergy() * 100 / player.maxEnergy

# to change Energy method handleEnergyChange needs to be called by item that changes energy
# e.g. in special_item -> if it is picked up, energy changes by -5 
func handleEnergyChange(changeEnergy):
	currentEnergy += changeEnergy # adds the amount of energy (set in each item)
	currentEnergy = clamp(currentEnergy, 0, player.maxEnergy) # clamps value, so it doesn go beyond 100
	
	player.setCurrentEnergy(currentEnergy) # sets current Energy in player
