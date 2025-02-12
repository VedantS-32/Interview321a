extends Node2D
enum outfit_type {NONE, HAT, SHIRT, PANT, SHOES}

@export var drop_position : Vector2 = Vector2(0, 0)
@export var outfit : outfit_type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var globalSignal = get_node(GlobalSignal.get_path())
	globalSignal.outfitEquipped.connect(Callable(self, "turn_off_lights"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_anchor_area_area_entered(area: Area2D) -> void:
	var outfitInRange = area.get_parent() as Outfit
	if outfitInRange:
		if not outfit:
			print("Anchor outfit enum not selected")
		elif not outfitInRange.outfit:
			print("Outfit enum not selected")
		elif outfitInRange.outfit == outfit:
			var light = get_node("PointLight2D") as PointLight2D
			var tween = create_tween()
			tween.tween_property(light, "energy", 16, 0.5)
			outfitInRange.anchorPos = self.global_position
			outfitInRange.inRange = true


func _on_anchor_area_area_exited(area: Area2D) -> void:
	var outfitInRange = area.get_parent() as Outfit
	if outfitInRange:
		var light = get_node("PointLight2D") as PointLight2D
		var tween = create_tween()
		tween.tween_property(light, "energy", 0, 0.5)
		outfitInRange.inRange = false

func turn_off_lights() -> void:
	var light = get_node("PointLight2D") as PointLight2D
	var tween = create_tween()
	tween.tween_property(light, "energy", 0, 0.5)
