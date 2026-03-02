extends Button

var outlineAtual := 0.0
var glowAtual := 0.0
var tweenGlow : Tween

func _ready():
	# núcleo da letra (nítido)
	add_theme_constant_override("outline_size", 1)
	add_theme_color_override("font_outline_color", Color(0.8, 0.95, 1.0, 1.0))

	# halo neon externo (sem deslocamento)
	add_theme_constant_override("shadow_offset_x", 0)
	add_theme_constant_override("shadow_offset_y", 0)
	add_theme_constant_override("shadow_outline_size", 0)
	add_theme_color_override("font_shadow_color", Color(0.6, 0.85, 1.0, 0.25))

	mouse_entered.connect(_on_hover_on)
	mouse_exited.connect(_on_hover_off)
	focus_entered.connect(_on_hover_on)
	focus_exited.connect(_on_hover_off)


func _on_hover_on():
	if tweenGlow:
		tweenGlow.kill()

	# pulsação contínua do halo
	tweenGlow = create_tween().set_loops()
	tweenGlow.tween_method(AtualizarHalo, 20.0, 34.0, 1.0)
	tweenGlow.tween_method(AtualizarHalo, 26.0, 16.0, 0.9)

	AnimarGlow(2, 20)


func _on_hover_off():
	if tweenGlow:
		tweenGlow.kill()

	AnimarGlow(0, 0)


func AnimarGlow(outlineFinal, glowFinal):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_method(AtualizarOutline, outlineAtual, outlineFinal, 0.2)
	tween.parallel().tween_method(AtualizarHalo, glowAtual, glowFinal, 0.2)


func AtualizarOutline(valor):
	outlineAtual = valor
	add_theme_constant_override("outline_size", valor)


func AtualizarHalo(valor):
	glowAtual = valor

	# raio do brilho (expansão real do neon)
	add_theme_constant_override("shadow_outline_size", valor)

	# intensidade cresce com o raio → luz difusa real
	var intensidade = clamp(valor / 26.0, 0.0, 1.0)

	add_theme_color_override(
		"font_shadow_color",
		Color(0.6, 0.85, 1.0, 0.25 + intensidade * 0.45)
	)
