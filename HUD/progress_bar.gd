extends TextureProgressBar

@export var player: Player

func _ready():
	# connected to player script 
	player.energyChanged.connect(update)
	update()

func update(): 
	# value is shown as percentage of maxHealth
	value = player.currentHealth * 100 / player.maxHealth
