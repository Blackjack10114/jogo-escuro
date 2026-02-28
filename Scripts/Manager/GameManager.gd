extends Node

enum EstadoJogo { Menu, Jogando, Pausado }

var estadoAtual: EstadoJogo = EstadoJogo.Menu

signal jogoIniciado
signal jogoPausado
signal jogoRetomado

# ===== PUZZLES =====
signal puzzleResolvido(idPuzzle: String)
var puzzlesResolvidos: Dictionary = {}

func IniciarJogo():
	estadoAtual = EstadoJogo.Jogando
	get_tree().paused = false
	jogoIniciado.emit()

func PausarJogo():
	if estadoAtual != EstadoJogo.Jogando:
		return
	estadoAtual = EstadoJogo.Pausado
	get_tree().paused = true
	jogoPausado.emit()

func RetomarJogo():
	if estadoAtual != EstadoJogo.Pausado:
		return
	estadoAtual = EstadoJogo.Jogando
	get_tree().paused = false
	jogoRetomado.emit()

func VoltarMenuPrincipal():
	get_tree().paused = false
	estadoAtual = EstadoJogo.Menu
	get_tree().change_scene_to_file("res://Scenes/MenuPrincipal.tscn")

func RegistrarPuzzleResolvido(idPuzzle: String):
	if puzzlesResolvidos.has(idPuzzle):
		return
	
	puzzlesResolvidos[idPuzzle] = true
	puzzleResolvido.emit(idPuzzle)
	print("Puzzle resolvido:", idPuzzle)

func PuzzleJaResolvido(idPuzzle: String) -> bool:
	return puzzlesResolvidos.has(idPuzzle)
