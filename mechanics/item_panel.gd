extends Control

@onready var item_container = $HBoxContainer/Panel/MarginContainer/VBoxContainer
var outfit_class = preload("res://mechanics/outfit/outfit.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	var panels = item_container.get_children()
	var i = 1
	for panel in panels:
		if event.is_action_pressed("Click") and panel.get_global_rect().has_point(event.position):
			var new_outfit = outfit_class.instantiate()
			new_outfit.global_position = event.position
			new_outfit.initialize(Vector2(event.position), i)
			get_viewport().add_child(new_outfit)
		i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
