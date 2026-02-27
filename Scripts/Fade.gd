extends Control

@onready var rect = $ColorRect

func FadeOut():
	rect.modulate.a = 0
	visible = true
	
	var tween = create_tween()
	tween.tween_property(rect, "modulate:a", 1.0, 0.4)

func FadeIn():
	var tween = create_tween()
	tween.tween_property(rect, "modulate:a", 0.0, 0.4)
	tween.finished.connect(func(): visible = false)
	
