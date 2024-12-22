extends ProgressBar

var energy = 0 : set = _set_energy

func _set_energy(new_energy):
	energy = min(max_value, new_energy)
	value = energy

func init_energy(_energy):
	energy = _energy
	max_value = energy
	value = energy
