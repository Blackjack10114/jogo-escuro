extends Node
class_name PuzzleController

@export var porta: Porta
@export var ativadores: Array[Node] = []
@export var idPuzzle := "puzzle_"

# ===== LUZES DA ÁREA =====
@export var luzes_area: Array[PointLight2D] = []

var ativaveis: Array[Ativador] = []
var resolvido := false

func _ready():
	print("PuzzleController iniciou")

	# Garante que começa apagado
	_desativar_luzes()

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
		_ativar_luzes()
	else:
		_verificar_puzzle(false)

func _encontrar_ativavel(node: Node) -> Ativador:
	if node is Ativador:
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
	_ativar_luzes()
	GameManager.RegistrarPuzzleResolvido(idPuzzle)
	_travar_interacoes()

# ===== LUZES (SIMPLES) =====
func _ativar_luzes():
	for luz in luzes_area:
		if is_instance_valid(luz):
			luz.visible = false

func _desativar_luzes():
	for luz in luzes_area:
		if is_instance_valid(luz):
			luz.visible = true

# ===== RESTO =====
func _travar_interacoes():
	for a in ativaveis:
		if a is Altar:
			(a as Altar).bloqueado = true

func _abrir_porta():
	print("abrir_porta chamado. porta =", porta)
	if porta:
		porta.ativar()
	else:
		push_warning("PuzzleController: porta não está no Inspector!")

func _fechar_porta():
	if porta:
		porta.desativar()
