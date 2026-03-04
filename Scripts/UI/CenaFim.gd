extends Control

@export var fade: ColorRect
@export var texto_continuar: Label

@export var delay_Texto := 2.5
@export var tempo_Fade := 3.0
@export var velocidade_Piscar := 4.0

var pode_continuar := false
var ja_saiu := false
var t := 0.0


func _ready():
	if fade:
		fade.visible = true
		fade.modulate.a = 1.0

	if texto_continuar:
		texto_continuar.visible = false

	var tw := create_tween()
	if fade:
		tw.tween_property(fade, "modulate:a", 0.0, tempo_Fade)

	await get_tree().create_timer(delay_Texto).timeout

	if texto_continuar:
		texto_continuar.visible = true
	
	pode_continuar = true


func _process(delta):
	if not texto_continuar or not texto_continuar.visible:
		return

	t += delta
	var a := 0.25 + (sin(t * velocidade_Piscar) * 0.5 + 0.5) * 0.75
	texto_continuar.modulate.a = a


func _unhandled_input(event):
	if not pode_continuar or ja_saiu:
		return

	# teclado
	if event is InputEventKey and event.pressed and not event.echo:
		sair()

	# mouse
	elif event is InputEventMouseButton and event.pressed:
		sair()

func sair():
	if ja_saiu:
		return
		
	ja_saiu = true

	var tw := create_tween()
	if fade:
		tw.tween_property(fade, "modulate:a", 1.0, 0.5)
		await tw.finished

	GameManager.ResetarProgresso()
	GameManager.VoltarMenuPrincipal()
