extends Node2D

@export var path: Path2D
@export var apm_target = 15
@export var apmCounter: APMCounter
@export var curve: Curve2D
@export var background: ParallaxBackground
@export var sprite: AnimatedSprite2D

signal score_updated(new_score)

var alternate = false
var key = "ui_left"
var started = false
var ended = false
var score = 0
var time_passed = 0
var game_length = 5

func _process(delta):
	if Input.is_action_just_pressed(key):
		if not started:
			apmCounter.start()
			started = true
			sprite.play()
		apmCounter.add_action()
		key = getNextKey()
		
	if started and not ended: 
		time_passed += delta
		var apm = apmCounter.get_average_apm()
		score += apm
		score_updated.emit(score)
		var t = clampf(apm / apm_target, 0, 1)
		var pos = path.curve.samplef(t)
		position = position.slerp(pos, 0.1)
		background.scroll_offset.x = -score
		sprite.speed_scale = apm
	
	if time_passed > game_length:
		ended = true
		position = position.slerp(path.curve.get_point_position(2), 0.1)
		
	if ended and Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
		
func getNextKey():
	match key:
		"ui_left": return "ui_right"
		"ui_right": return "ui_left"

func _on_start_game():
	started = false
