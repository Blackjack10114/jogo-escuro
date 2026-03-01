class_name CaixaSimples
extends CharacterBody2D

@export var velocidade_empurrao := 90.0
@export var peso_conta_como_corpo := true # pra botão long trigger contar como "corpo"

var empurrando := false
var dir_empurrao := Vector2.ZERO

func _physics_process(_delta):
	if empurrando:
		velocity = dir_empurrao * velocidade_empurrao
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# reseta; o player vai setar de novo enquanto estiver empurrando
	empurrando = false
	dir_empurrao = Vector2.ZERO

# chamado pelo player quando ele estiver empurrando
func empurrar(direcao: Vector2) -> void:
	empurrando = true
	dir_empurrao = direcao.normalized()
