extends Node

class_name APMCounter

var timer = 0
var running = false
var actions: Array[float] = []

func start():
	running = true
	
func _process(delta):
	timer += delta
	
func add_action():
	actions.append(timer)
	
func get_apm(time: float = 5.0) -> float:
	var recent_items = actions.filter(func (x): return x >= (timer - time))
	var count = recent_items.size()
	return float(count) / time

func get_average_apm() -> float:
	return ((get_apm(10.0)/3) + (get_apm(5.0)/3) + get_apm(2.5) /3)
