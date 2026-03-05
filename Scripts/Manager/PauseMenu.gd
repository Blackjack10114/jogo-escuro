extends Control

@export var pause_panel: Control
@export var controles_panel: Control

@export var cena_jogo: String = "res://Scenes/main_game.tscn"

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	GameManager.jogoPausado.connect(_ao_pausar)
	GameManager.jogoRetomado.connect(_ao_retornar)

	abrir_painel_pause()

func _ao_pausar():
	visible = true
	abrir_painel_pause()

func _ao_retornar():
	visible = false

func abrir_painel_pause() -> void:
	pause_panel.visible = true
	controles_panel.visible = false

func abrir_controles() -> void:
	pause_panel.visible = false
	controles_panel.visible = true

# ---- botões do PausePanel ----
func _on_botaoVoltar_pressed() -> void:
	visible = false
	GameManager.RetomarJogo()

func _on_botaoReiniciar_pressed() -> void:
	visible = false
	get_viewport().gui_release_focus()
	get_tree().paused = false
	GameManager.ResetarProgresso()
	GameManager.IrParaJogo(cena_jogo)

func _on_botaoControles_pressed() -> void:
	abrir_controles()

func _on_botaoSair_pressed() -> void:
	visible = false
	get_viewport().gui_release_focus()
	GameManager.VoltarMenuPrincipal()

# ---- botão voltar da tela Controles ----
func _on_botaoVoltarControles_pressed() -> void:
	abrir_painel_pause()
