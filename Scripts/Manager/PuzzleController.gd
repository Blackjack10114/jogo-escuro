extends Node

@export var porta: Porta
@export var altares: Array[Node]
@export var idPuzzle := "altar_principal"

var altares_area: Array[Altar] = []
var resolvido := false


func _ready():
	print("PuzzleController iniciou")
	
	# Detecta automaticamente qualquer Altar dentro das cenas
	for altar_root in altares:
		var area: Altar = _encontrar_altar(altar_root)
		if area:
			altares_area.append(area)

			# Conecta ao sinal padrão da classe Ativavel
			if not area.estado_alterado.is_connected(_verificar_puzzle):
				area.estado_alterado.connect(_verificar_puzzle)

	print("Altares detectados:", altares_area.size())

	if GameManager.PuzzleJaResolvido(idPuzzle):
		resolvido = true
		_abrir_porta()
		_travar_altares()
	else:
		_verificar_puzzle(false)


func _encontrar_altar(node: Node) -> Altar:
	if node is Altar:
		return node
		
	for filho in node.get_children():
		var resultado: Altar = _encontrar_altar(filho)
		if resultado:
			return resultado
			
	return null


func _verificar_puzzle(_novo_estado: bool) -> void:
	if resolvido:
		return

	print("Verificando puzzle...")

	for altar in altares_area:
		print("Altar", altar.name, "ativo?", altar.ativo)
		if not altar.ativo:
			_fechar_porta()
			return

	print("PUZZLE RESOLVIDO")
	resolvido = true
	
	_abrir_porta()
	GameManager.RegistrarPuzzleResolvido(idPuzzle)
	_travar_altares()

func _travar_altares():
	for altar in altares_area:
		altar.bloqueado = true


func _abrir_porta():
	if porta:
		print("ABRINDO PORTA")
		porta.ativar()


func _fechar_porta():
	if porta:
		porta.desativar()
