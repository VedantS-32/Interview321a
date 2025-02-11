class_name Outfit

extends Node2D

enum outfit_type {NONE, HAT, SHIRT, PANT, SHOES}

@export var outfit : outfit_type

var inRange : bool = false
var isEquiped : bool = false
var isDragging : bool = false
var isMouseOver : bool = false
var mousePos : Vector2 = Vector2.ZERO
var difference : Vector2
var delay = 0.15
var anchorPos : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isDragging:
		var tween = create_tween()
		tween.tween_property(self, "global_position", get_global_mouse_position(), delay)
	elif inRange:
		var tween = create_tween()
		tween.tween_property(self, "global_position", anchorPos, delay)
		GlobalSignal.emit_signal("outfitEquipped")
		inRange = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click") and isMouseOver:
		isDragging = true
	elif event.is_action_released("Click"):
		isDragging = false

func _on_area_2d_mouse_entered() -> void:
	isMouseOver = true

func _on_area_2d_mouse_exited() -> void:
	isMouseOver = false
