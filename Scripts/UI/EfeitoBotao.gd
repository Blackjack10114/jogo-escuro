extends Button

@onready var glow: TextureRect = get_parent().get_node("Glow")

var tween: Tween

func _ready() -> void:
	if glow:
		glow.modulate.a = 0.0
		glow.mouse_filter = Control.MOUSE_FILTER_IGNORE

	mouse_entered.connect(_on_on)
	mouse_exited.connect(_on_off)
	focus_entered.connect(_on_on)
	focus_exited.connect(_on_off)

func _on_on() -> void:
	_anim_glow(1.0)

func _on_off() -> void:
	_anim_glow(0.0)

func _anim_glow(target_alpha: float) -> void:
	if glow == null:
		return
	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(glow, "modulate:a", target_alpha, 0.15)
