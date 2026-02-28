extends StaticBody2D

@export var começa_aberta := false

var aberta := false

@onready var colisao = $CollisionShape2D
@onready var sprite = $Sprite2D


func _ready():
	aberta = começa_aberta
	atualizar_estado()


func alternar():
	aberta = !aberta
	atualizar_estado()


func abrir():
	if aberta:
		return
		
	aberta = true
	atualizar_estado()


func fechar():
	if not aberta:
		return
		
	aberta = false
	atualizar_estado()


func atualizar_estado():
	colisao.disabled = aberta
	sprite.modulate.a = 0.3 if aberta else 1.0
