extends Control

@onready var pause_panel: Control = $PauseContainer/PausePanel
@onready var controles_root: Control = $Controles

func _ready() -> void:
	print("PauseUi READY. estadoAtual =", GameManager.estadoAtual)

	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	GameManager.jogoPausado.connect(_ao_pausar)
	GameManager.jogoRetomado.connect(_ao_retornar)

func _ao_pausar():
	visible = true
	abrir_painel_pause()

func _ao_retornar():
	visible = false
	
func _input(event) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		print("Tecla chegou no PauseUi:", (event as InputEventKey).keycode)

func mostrar_pause() -> void:
	visible = true
	GameManager.PausarJogo()
	abrir_painel_pause()

func esconder_pause() -> void:
	visible = false
	GameManager.RetomarJogo()

func abrir_painel_pause() -> void:
	pause_panel.visible = true
	controles_root.visible = false

func abrir_controles() -> void:
	pause_panel.visible = false
	controles_root.visible = true

func fechar_controles() -> void:
	abrir_painel_pause()

# ===== botões do PausePanel =====
func _on_botaoVoltar_pressed() -> void:
	esconder_pause()

func _on_botaoControles_pressed() -> void:
	abrir_controles()

func _on_botaoSair_pressed() -> void:
	# fecha UI e solta foco
	visible = false
	get_viewport().gui_release_focus()

	# garante despausar e evitar ficar preso no pause
	GameManager.RetomarJogo() # ou get_tree().paused = false direto

	# troca de cena via GameManager
	GameManager.VoltarMenuPrincipal()
# ===== botão voltar da tela Controles =====
func _on_botaoVoltarControles_pressed() -> void:
	fechar_controles()
