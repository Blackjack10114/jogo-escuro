extends Control

@onready var pause_panel: Control = $CenterContainer
@onready var controles: Control = $ControlesUI

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	pause_panel.visible = true
	controles.visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		if GameManager.estadoAtual == GameManager.EstadoJogo.Jogando:
			MostrarPause()
		elif GameManager.estadoAtual == GameManager.EstadoJogo.Pausado:
			if controles.visible:
				fechar_controles()
			else:
				EsconderPause()

func MostrarPause():
	visible = true
	GameManager.PausarJogo()
	pause_panel.visible = true
	controles.visible = false

func EsconderPause():
	visible = false
	GameManager.RetomarJogo()

func _on_botaoContinuar_pressed():
	EsconderPause()

func _on_botaoMenu_pressed():
	GameManager.VoltarMenuPrincipal()

func _on_botaoControles_pressed():
	abrir_controles()

func abrir_controles():
	pause_panel.visible = false
	controles.visible = true

func fechar_controles():
	controles.visible = false
	pause_panel.visible = true
