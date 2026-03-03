extends TextureButton

@onready var label: Label = $Label
var tween: Tween

func _ready():
	mouse_entered.connect(_hover_on)
	mouse_exited.connect(_hover_off)
	focus_entered.connect(_hover_on)
	focus_exited.connect(_hover_off)

func _hover_on():
	_animar(Vector2(1.06, 1.06))

func _hover_off():
	_animar(Vector2(1, 1))

func _animar(target_scale: Vector2):
	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", target_scale, 0.12)
