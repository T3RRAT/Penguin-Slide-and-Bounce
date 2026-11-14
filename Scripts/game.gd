extends Node2D

var dragging = false
var of = Vector2(0.0,0.0)

var cam_Offset = Vector2(0,0)
var min_Offset = -25
var max_Offset = 25

var screen_Size = DisplayServer.screen_get_size()


@onready var overlay_elements = $Overlay/Node2D/Elements


@onready var penguin = $Penguin
@onready var drag_indicator = $"Penguin/Drag Indicator"

var diVisible = Color("ffffff90")
var invisible = Color("ffffff00")

var center_Vision = Vector2(0,0)
var target_Vision = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_Vision = overlay_elements.position
	target_Vision = center_Vision
	
	#penguin.velocity = Vector2(200,-200).normalized() * 300.0
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging == true:
		drag_indicator.modulate = lerp(drag_indicator.modulate, diVisible, delta * 10)
		drag_indicator.global_position = get_global_mouse_position()
	else:
		drag_indicator.modulate = lerp(drag_indicator.modulate, invisible, delta * 10)
	
	
	cam_Offset = ((get_viewport().get_mouse_position() - Vector2(screen_Size)/3) - position) * 0.05
	cam_Offset.x = clamp(cam_Offset.x, min_Offset, max_Offset)
	cam_Offset.y = clamp(cam_Offset.y, min_Offset/2, max_Offset/2)
	
	#$Overlay/Node2D/Elements.global_position = $Overlay/Node2D.position + cam_Offset
	
	
	
	pass


func _on_button_button_down() -> void:
	dragging = true
	of = get_local_mouse_position() - penguin.position
	print(of)
	pass # Replace with function body.


func _on_button_button_up() -> void:
	dragging = false
	
	
	
	print("chicken")
	pass # Replace with function body.
