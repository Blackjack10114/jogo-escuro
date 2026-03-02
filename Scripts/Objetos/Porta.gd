class_name Porta
extends StaticBody2D

@export var comeca_aberta := false

@onready var colisao: CollisionShape2D = get_node_or_null("CollisionShape2D")
@onready var looks: AnimatedSprite2D = get_node_or_null("looks") 

var aberta := false

func _ready() -> void:
	set_aberta(comeca_aberta)

func ativar() -> void:
	set_aberta(true)

func desativar() -> void:
	set_aberta(false)

func alternar() -> void:
	set_aberta(not aberta)

func get_ativo() -> bool:
	return aberta

func set_aberta(v: bool) -> void:
	aberta = v

	if colisao:
		colisao.set_deferred("disabled", aberta)

	if looks:
		looks.play("aberta" if aberta else "fechada")
