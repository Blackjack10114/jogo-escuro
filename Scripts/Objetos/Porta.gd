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
	print("[Porta] set_aberta(", v, ")  node=", self)
	print("  colisao=", colisao, " looks=", looks)

	aberta = v

	if colisao:
		colisao.disabled = aberta
	else:
		push_warning("[Porta] NÃO achei CollisionShape2D. O nó tem esse nome e é filho direto da Porta?")

	if looks:
		looks.play("aberta" if aberta else "fechada")
	else:
		push_warning("[Porta] NÃO achei %looks. O AnimatedSprite2D está com Unique Name e chamado looks?")
