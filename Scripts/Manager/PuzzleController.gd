extends Node

@export var porta: Porta
@export var ativadores: Array[Node] = []
@export var idPuzzle := "puzzle_"

var ativaveis: Array[Ativavel] = []
var resolvido := false

func _ready():
	print("PuzzleController iniciou")

	for root in ativadores:
		var a := _encontrar_ativavel(root)
		if a:
			ativaveis.append(a)

			if not a.estado_alterado.is_connected(_verificar_puzzle):
				a.estado_alterado.connect(_verificar_puzzle)

	print("Ativaveis detectados:", ativaveis.size())

	if GameManager.PuzzleJaResolvido(idPuzzle):
		resolvido = true
		_abrir_porta()
		_travar_interacoes()
	else:
		_verificar_puzzle(false)

func _encontrar_ativavel(node: Node) -> Ativavel:
	if node is Ativavel:
		return node

	for filho in node.get_children():
		var resultado := _encontrar_ativavel(filho)
		if resultado:
			return resultado

	return null

func _verificar_puzzle(_novo_estado: bool) -> void:
	if resolvido:
		return

	for a in ativaveis:
		if not a.ativo:
			_fechar_porta()
			return

	print("PUZZLE RESOLVIDO")
	resolvido = true

	_abrir_porta()
	GameManager.RegistrarPuzzleResolvido(idPuzzle)
	_travar_interacoes()

func _travar_interacoes():
	for a in ativaveis:
		if a is Altar:
			(a as Altar).bloqueado = true

func _abrir_porta():
	if porta:
		porta.ativar()

func _fechar_porta():
	if porta:
		porta.desativar()
