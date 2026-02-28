extends Node

@export var porta: Node
@export var altares: Array[Node]
@export var idPuzzle := "altar_principal"

var resolvido := false

func _ready():
	# Se já foi resolvido antes, abre a porta direto
	if GameManager.PuzzleJaResolvido(idPuzzle):
		porta.abrir()
		resolvido = true
		return
	
	for altar in altares:
		if altar.has_signal("altar_ativado"):
			altar.altar_ativado.connect(_verificar_puzzle)

func _verificar_puzzle():
	for altar in altares:
		if not altar.ativado:
			porta.fechar()
			resolvido = false
			return
	
	porta.abrir()
	
	if not resolvido:
		resolvido = true
		GameManager.RegistrarPuzzleResolvido(idPuzzle)
