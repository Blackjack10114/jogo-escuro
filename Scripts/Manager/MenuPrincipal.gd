extends Control

@export var panel_menu: Control
@export var panel_opcoes: Control
@export var panel_controles: Control
@export var fade: ColorRect

@export var tempo_fade := 0.5

const SCENE_JOGO := "res://Scenes/main_game.tscn"
const SCENE_CREDITOS := "res://Scenes/UI/Creditos.tscn"

var _trocando_cena := false

func _ready() -> void:
	_mostrar_menu()

	if fade:
		fade.visible = true
		fade.modulate.a = 0.0

	if is_instance_valid(AudioManager):
		AudioManager.play_music(AudioManager.musica_menu)


func _mostrar_menu() -> void:
	panel_menu.visible = true
	panel_opcoes.visible = false
	panel_controles.visible = false


func _mostrar_opcoes() -> void:
	panel_menu.visible = false
	panel_opcoes.visible = true
	panel_controles.visible = false


func _mostrar_controles() -> void:
	panel_menu.visible = false
	panel_opcoes.visible = false
	panel_controles.visible = true


# ---- botões do MENU principal ----
func _on_botaoJogar_pressed() -> void:
	if _trocando_cena:
		return
	_trocando_cena = true

	# garante que a cena existe (isso pega erro de maiúsculas/minúsculas na build)
	if not ResourceLoader.exists(SCENE_JOGO):
		push_error("Cena do jogo não encontrada: " + SCENE_JOGO)
		_trocando_cena = false
		return

	if fade:
		fade.visible = true
		fade.modulate.a = 0.0
		var tw := create_tween()
		tw.tween_property(fade, "modulate:a", 1.0, tempo_fade)
		await tw.finished

	# chama o GameManager (deixa o caminho por conta dele também)
	GameManager.IrParaJogo(SCENE_JOGO)


func _on_botaoOpcoes_pressed() -> void:
	_mostrar_opcoes()


func _on_botaoCreditos_pressed() -> void:
	if _trocando_cena:
		return
	_trocando_cena = true

	if not ResourceLoader.exists(SCENE_CREDITOS):
		push_error("Cena de créditos não encontrada: " + SCENE_CREDITOS)
		_trocando_cena = false
		return

	var err := get_tree().change_scene_to_file(SCENE_CREDITOS)
	if err != OK:
		push_error("Erro ao trocar para Créditos: %s" % err)
		_trocando_cena = false


func _on_botaoSair_pressed() -> void:
	get_tree().quit()


# ---- botões do painel OPÇÕES ----
func _on_botaoVoltarOpcoes_pressed() -> void:
	_mostrar_menu()


func _on_botaoControlesOpcoes_pressed() -> void:
	_mostrar_controles()


# ---- botão voltar do painel CONTROLES ----
func _on_botaoVoltarControles_pressed() -> void:
	_mostrar_opcoes()
