extends Area2D

signal vector_created(vector)

@export var maximum_length := 400



var stopWorking = false
var touch_down := false
var position_start := Vector2.ZERO
var position_end := Vector2.ZERO

var vector := Vector2.ZERO

func _ready() -> void:
	
	connect("input_event", Callable(self, "_on_input_event"))


func _draw() -> void:
	draw_line(position_start - global_position, 
		(position_end - global_position), 
		Color.BLUE, 
		8)
	
	draw_line(position_start - global_position, 
		position_start - global_position + vector, 
		Color.RED, 
		16)


func _reset() -> void:
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	
	queue_redraw()
	

func _input(event) -> void:
	
	if event.is_action_released("ui_touch") :#&& stopWorking == false:
		touch_down = false
		emit_signal("vector_created", vector)
		_reset()
		stopWorking = true
	
	if not touch_down:
		return
	
	if event is InputEventMouseMotion: #&& stopWorking == false:
		position_end = event.position
		vector = -(2*position_end - 2*position_start).limit_length(maximum_length)
		queue_redraw()


func _on_input_event(_viewport, event, _shape_idx) -> void:
	
	if event.is_action_pressed("ui_touch"):
		touch_down = true
		position_start = event.position



func stopchange_thingie():
	stopWorking = !stopWorking


func _on_mouse_entered() -> void:
	pass # Replace with function body.
