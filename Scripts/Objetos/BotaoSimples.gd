class_name BotaoSimples
extends Ativavel

@export var alvos: Array[Node] = []  # agora aceita Porta, qualquer Node

@onready var sprite: Sprite2D = get_node_or_null("Sprite2D")

func _ready():
	body_entered.connect(_on_body_entered)
	_set_estado(false)

func _on_body_entered(_body):
	if ativo:
		return

	ativar()
	for alvo in alvos:
		if is_instance_valid(alvo):
			alvo.call("ativar")  # se não existir, não quebra
			# ou: if alvo.has_method("ativar"): alvo.ativar()
			
func _ao_ativar():
	if sprite:
		sprite.modulate.a = 0.7
