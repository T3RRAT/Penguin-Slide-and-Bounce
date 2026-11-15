extends Node2D

var dragging = false
var of = Vector2(0.0,0.0)

var cam_Offset = Vector2(0,0)
var min_Offset = -25
var max_Offset = 25

var bounces = 0

var speedCost = 10
var speedCostMult = 1
var penguinSpeedMult = 1

var bounceCost = 50
var bounceCostMult = 1
var bounceBounce = 1

var mitosisCost = 500
var mitosisCostMult = 1
var currentPenguins = 1
var targetPenguins = 1



var screen_Size = DisplayServer.screen_get_size()

@onready var snowPile = preload("res://Scenes/snow_pile.tscn")

@onready var penguin_Scene = preload("res://Scenes/penguin.tscn")

@onready var overlay_elements = $Overlay/Node2D/Elements
@onready var text = $Overlay/Node2D/Elements/Text

@onready var vecCreator = $Overlay/VectorCreator
@onready var colorCover = $Overlay/ColorRect


@onready var button = $Overlay/Button
@onready var speed_Upgrade_Button = $Overlay/Button/VBoxContainer/Speed
@onready var bounce_Upgrade_Button = $"Overlay/Button/VBoxContainer/Bounce Factor"
@onready var mitosis_Upgrade_Button = $Overlay/Button/VBoxContainer/Mitosis


var diVisible = Color("ffffff90")
var invisible = Color("ffffff00")

var center_Vision = Vector2(0,0)
var target_Vision = Vector2(0,0)

var buttonClosePos = null
var buttonOpenPos = null

var buttonOpen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_Vision = overlay_elements.position
	target_Vision = center_Vision
	
	buttonClosePos = button
	
	buttonClosePos = button.position
	buttonOpenPos = button.position + Vector2(-300,0)
	#penguin.velocity = Vector2(200,-200).normalized() * 300.0
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if buttonOpen == true:
		button.position = lerp(button.position, buttonOpenPos, delta * 6)
	else:
		button.position = lerp(button.position, buttonClosePos, delta * 6 )
	
	
	speed_Upgrade_Button.text = "Plus Speed: %d Bounces" % speedCost
	bounce_Upgrade_Button.text = "More Bounce: %d Bounces" % bounceCost
	mitosis_Upgrade_Button.text = "Mitosis: %d Bounces" % mitosisCost
	
	
	#$Overlay/Node2D/Elements.global_position = $Overlay/Node2D.position + cam_Offset
	
	text.text = "Bounces: %d" % bounces
	
	if currentPenguins < targetPenguins:
		var p = penguin_Scene.instantiate()
		add_child.call_deferred(p)
		
		currentPenguins += 1
	
	pass






func _on_vector_creator_vector_created(vector: Variant) -> void:
	
	for penguin in get_children():
		if penguin.has_method("launch"):
			penguin.call("launch",vector)
	
	print("Chicken")
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	#append a new thingie
	pass # Replace with function body.


func _on_button_pressed() -> void:
	buttonOpen = !buttonOpen
	pass # Replace with function body.


func _on_speed_pressed() -> void:
	if bounces >= speedCost:
		penguinSpeedMult = penguinSpeedMult * 1.25
		bounces -= speedCost
		speedCost = speedCost + 10 * speedCostMult
		speedCostMult = speedCostMult * 1.1
	pass # Replace with function body.


func _on_bounce_factor_pressed() -> void:
	if bounces >= bounceCost:
		bounceBounce = bounceBounce * 2
		bounces -= bounceCost
		bounceCost = bounceCost + 30 * bounceCostMult
		bounceCostMult = bounceCostMult * 1.4
	pass # Replace with function body.


func _on_mitosis_pressed() -> void:
	if bounces >= mitosisCost:
		targetPenguins *= 2
		bounces -= mitosisCost
		mitosisCost = mitosisCost * mitosisCostMult
		mitosisCostMult = mitosisCostMult * 2
	pass # Replace with function body.
	
	
