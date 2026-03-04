extends Node

enum EstadoJogo { Menu, Jogando, Pausado }

var estadoAtual: EstadoJogo = EstadoJogo.Menu

signal jogoIniciado
signal jogoPausado
signal jogoRetomado

# ===== PUZZLES =====
signal puzzleResolvido(idPuzzle: String)
var puzzlesResolvidos: Dictionary = {}

# Ajuste os paths conforme seu projeto
const SCENE_MENU := "res://Scenes/UI/MenuPrincipal.tscn"
const SCENE_JOGO := "res://Scenes/SceneTeste/Hugo.tscn"

func _ready() -> void:
	print("[GameManager] READY id=", get_instance_id())
	process_mode = Node.PROCESS_MODE_ALWAYS

	# Segurança: se iniciar o jogo e estiver pausado por algum motivo
	if get_tree().paused:
		get_tree().paused = false


# =========================
#  Fluxo de cenas / estado
# =========================
func IrParaJogo(scene_path: String = SCENE_JOGO) -> void:
	print("[GameManager] IrParaJogo:", scene_path)

	# Nunca entrar no jogo pausado
	get_tree().paused = false
	estadoAtual = EstadoJogo.Jogando

	# Troca de cena de forma segura
	call_deferred("_trocar_cena", scene_path)

	# Emite sinal para quem quiser reagir
	jogoIniciado.emit()


func VoltarMenuPrincipal() -> void:
	print("[GameManager] VoltarMenuPrincipal chamado. paused antes=", get_tree().paused)
	get_tree().paused = false
	estadoAtual = EstadoJogo.Menu
	call_deferred("_trocar_cena", SCENE_MENU)


func _trocar_cena(path: String) -> void:
	print("[GameManager] Trocando cena para:", path)
	get_viewport().gui_release_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var err := get_tree().change_scene_to_file(path)
	print("[GameManager] change_scene err=", err)


# =========================
#  Pause / Resume
# =========================
func PausarJogo() -> void:
	print("[GameManager] PausarJogo chamado. estadoAtual =", estadoAtual)
	if estadoAtual != EstadoJogo.Jogando:
		print("[GameManager] NÃO pausou (não está em Jogando)")
		return

	estadoAtual = EstadoJogo.Pausado
	get_tree().paused = true
	jogoPausado.emit()


func RetomarJogo() -> void:
	print("[GameManager] RetomarJogo chamado. estadoAtual =", estadoAtual)
	if estadoAtual != EstadoJogo.Pausado:
		print("[GameManager] NÃO retomou (não está em Pausado)")
		return

	estadoAtual = EstadoJogo.Jogando
	get_tree().paused = false
	jogoRetomado.emit()


# =========================
#  Input global (ESC)
# =========================
func _input(event: InputEvent) -> void:
	# ESC não deve fazer nada no Menu
	if estadoAtual == EstadoJogo.Menu:
		return

	if event.is_action_pressed("ui_cancel"):
		print("ESC no GameManager. estado =", estadoAtual)
		if estadoAtual == EstadoJogo.Jogando:
			PausarJogo()
		elif estadoAtual == EstadoJogo.Pausado:
			RetomarJogo()


# =========================
#  Puzzles
# =========================
func RegistrarPuzzleResolvido(idPuzzle: String) -> void:
	if puzzlesResolvidos.has(idPuzzle):
		return

	puzzlesResolvidos[idPuzzle] = true
	puzzleResolvido.emit(idPuzzle)
	print("Puzzle resolvido:", idPuzzle)


func PuzzleJaResolvido(idPuzzle: String) -> bool:
	return puzzlesResolvidos.has(idPuzzle)
