extends Node2D

var dragging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging == true:
		
		pass
	pass


func _on_button_button_down() -> void:
	dragging = true
	pass # Replace with function body.


func _on_button_button_up() -> void:
	dragging = false
	
	pass # Replace with function body.
