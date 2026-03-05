extends Node

enum EstadoJogo { Menu, Jogando, Pausado }
var estadoAtual: EstadoJogo = EstadoJogo.Menu

signal jogoIniciado
signal jogoPausado
signal jogoRetomado

signal puzzleResolvido(idPuzzle: String)
var puzzlesResolvidos: Dictionary = {}

# PRELOAD das cenas (melhor para build)
const SCENE_MENU: PackedScene = preload("res://Scenes/UI/MenuPrincipal.tscn")
const SCENE_JOGO: PackedScene = preload("res://Scenes/main_game.tscn")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	if get_tree().paused:
		get_tree().paused = false


func IrParaJogo() -> void:
	get_tree().paused = false
	estadoAtual = EstadoJogo.Jogando

	if is_instance_valid(AudioManager):
		AudioManager.play_music(AudioManager.musica_jogo)

	call_deferred("_trocar_cena_packed", SCENE_JOGO)
	jogoIniciado.emit()


func ReiniciarJogo() -> void:
	IrParaJogo()


func VoltarMenuPrincipal() -> void:
	get_tree().paused = false
	estadoAtual = EstadoJogo.Menu

	if is_instance_valid(AudioManager):
		AudioManager.play_music(AudioManager.musica_menu)

	call_deferred("_trocar_cena_packed", SCENE_MENU)


func IrParaCena(scene: PackedScene) -> void:
	get_tree().paused = false
	estadoAtual = EstadoJogo.Menu
	call_deferred("_trocar_cena_packed", scene)


func IrParaCenaSemMusica(scene: PackedScene) -> void:
	if is_instance_valid(AudioManager):
		AudioManager.stop_music()
	IrParaCena(scene)


func _trocar_cena_packed(scene: PackedScene) -> void:
	get_viewport().gui_release_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	var err := get_tree().change_scene_to_packed(scene)

	if err != OK:
		push_error("Erro ao trocar de cena: %s" % err)


func PausarJogo() -> void:
	if estadoAtual != EstadoJogo.Jogando:
		return

	estadoAtual = EstadoJogo.Pausado
	get_tree().paused = true
	jogoPausado.emit()


func RetomarJogo() -> void:
	if estadoAtual != EstadoJogo.Pausado:
		return

	estadoAtual = EstadoJogo.Jogando
	get_tree().paused = false
	jogoRetomado.emit()


func _input(event: InputEvent) -> void:
	if estadoAtual == EstadoJogo.Menu:
		return

	if event.is_action_pressed("ui_cancel"):
		if estadoAtual == EstadoJogo.Jogando:
			PausarJogo()
		elif estadoAtual == EstadoJogo.Pausado:
			RetomarJogo()


func RegistrarPuzzleResolvido(idPuzzle: String) -> void:
	if puzzlesResolvidos.has(idPuzzle):
		return

	puzzlesResolvidos[idPuzzle] = true
	puzzleResolvido.emit(idPuzzle)


func PuzzleJaResolvido(idPuzzle: String) -> bool:
	return puzzlesResolvidos.has(idPuzzle)


func ResetarProgresso() -> void:
	puzzlesResolvidos.clear()
