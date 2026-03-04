class_name BotaoSimples
extends Ativador

@export var alvos: Array[Node] = [] 

@onready var anim: AnimatedSprite2D = get_node_or_null("looks")

func _ready():
	body_entered.connect(_on_body_entered)
	_set_estado(false)
	_ao_desativar() 

func _on_body_entered(_body):
	if ativo:
		return

	ativar()
	for alvo in alvos:
		if is_instance_valid(alvo):
			alvo.call("ativar")  
			
func _ao_ativar():
	if anim:
		anim.play("ativado")

func _ao_desativar():
	if anim:
		anim.play("desativado")
