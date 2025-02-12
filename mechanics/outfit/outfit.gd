class_name Outfit

extends Node2D

enum outfit_type {NONE, HAT, SHIRT, PANTS, SHOES}

@export var outfit : outfit_type


var inRange : bool = false
var isEquiped : bool = false
var isDragging : bool = false
var toFree : bool = false
var mousePos : Vector2 = Vector2.ZERO
var difference : Vector2
var delay = 0.15
var anchorPos : Vector2 = Vector2.ZERO
var uiPos : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func initialize(pos: Vector2, pOutfit: outfit_type) -> void:
	var sprite = find_child("Sprite2D")
	match pOutfit:
		outfit_type.HAT:
			sprite.texture = load("res://texture/Hat_.png")
		outfit_type.SHIRT:
			sprite.texture = load("res://texture/Shirt_.png")
		outfit_type.PANTS:
			sprite.texture = load("res://texture/Pant_.png")
		outfit_type.SHOES:
			sprite.texture = load("res://texture/Shoes_.png")
	outfit = pOutfit
	uiPos = pos
	isDragging = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isDragging:
		var tween = create_tween()
		tween.tween_property(self, "global_position", get_global_mouse_position(), delay)
	elif inRange and (not toFree):
		var tween = create_tween()
		tween.tween_property(self, "global_position", anchorPos, delay)
		GlobalSignal.emit_signal("outfitEquipped")
		isEquiped = true
		inRange = false
	elif not isEquiped and (not isDragging):
		toFree = true
		var tween = create_tween()
		tween.tween_property(self, "global_position", uiPos, delay)
		var timer = Timer.new()
		timer.wait_time = delay
		timer.one_shot = true
		add_child(timer)
		timer.start()
		timer.timeout.connect(queue_free)

func _input(event: InputEvent) -> void:
	var sprite = find_child("Sprite2D") as Sprite2D
	if event.is_action_pressed("Click") and sprite.get_rect().has_point(to_local(event.position) * 4):
		isDragging = true
		isEquiped = false
	elif event.is_action_released("Click"):
		isDragging = false
