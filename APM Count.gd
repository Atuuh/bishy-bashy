extends Label

@export var apm: APMCounter

func _process(delta):
	text = "APM: %.2f" % apm.get_average_apm()
