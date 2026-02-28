extends Control

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _input(event):
	if event.is_action_pressed("pause"):
		if GameManager.estadoAtual == GameManager.EstadoJogo.Jogando:
			MostrarPause()
		elif GameManager.estadoAtual == GameManager.EstadoJogo.Pausado:
			EsconderPause()

func MostrarPause():
	visible = true
	GameManager.PausarJogo()

func EsconderPause():
	visible = false
	GameManager.RetomarJogo()

func _on_botaoContinuar_pressed():
	EsconderPause()

func _on_botaoMenu_pressed():
	GameManager.VoltarMenuPrincipal()
