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

func handleEnergyChange(changeEnergy):
	if currentHealth <= 0: 
		return 
	
	currentHealth -= changeEnergy
	player.setCurrentHealth(currentHealth) # sets current health in player
