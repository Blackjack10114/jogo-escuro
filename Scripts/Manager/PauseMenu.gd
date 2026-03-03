extends Control

@onready var pause_panel: Control = $PauseContainer/PausePanel
@onready var controles_root: Control = $Controles

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	abrir_painel_pause()

func _input(event) -> void:
	if event.is_action_pressed("pause"):
		if GameManager.estadoAtual == GameManager.EstadoJogo.Jogando:
			mostrar_pause()
		elif GameManager.estadoAtual == GameManager.EstadoJogo.Pausado:
			# se estiver na tela de controles, volta pro pause
			if controles_root.visible:
				fechar_controles()
			else:
				esconder_pause()

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
	GameManager.VoltarMenuPrincipal()

# ===== botão voltar da tela Controles =====
func _on_botaoVoltarControles_pressed() -> void:
	fechar_controles()
