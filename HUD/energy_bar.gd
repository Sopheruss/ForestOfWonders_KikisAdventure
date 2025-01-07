extends TextureProgressBar

@onready var player = get_tree().root.get_node("game").get_node("Player")
@onready var currentHealth = player.currentHealth
var changeHealth = currentHealth

func _ready():
	# connected to player script so that update is called every time there is an Energy Change
	player.energyChanged.connect(update)

func update(): 
	# value is shown as percentage of maxHealth
	value = player.currentHealth * 100 / player.maxHealth

# to change Energy method handleEnergyChange needs to be called by item that changes energy
# e.g. in special_item -> if it is picked up, energy changes 
func handleEnergyChange(changeEnergy):
	if currentHealth <= 0: # does not change Energy further if health is 0
		return 
	
	currentHealth -= changeEnergy # subtracts the amount of energy (set in each item)
	player.setCurrentHealth(currentHealth) # sets current health in player
