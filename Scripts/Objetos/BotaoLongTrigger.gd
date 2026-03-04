class_name BotaoLongTrigger
extends Ativador

@export var alvos: Array[Node] = []
@export var trava_se_alvo_ativo := true

@onready var anim: AnimatedSprite2D = get_node_or_null("looks")
var corpos_em_cima := 0

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	_set_estado(false)
	_ao_desativar()

func _on_body_entered(_body):
	corpos_em_cima += 1

	if corpos_em_cima == 1 and not ativo:
		ativar()
		for alvo in alvos:
			if is_instance_valid(alvo):
				alvo.call("ativar")

func _on_body_exited(_body):
	corpos_em_cima = max(0, corpos_em_cima - 1)

	if trava_se_alvo_ativo and _algum_alvo_ativo():
		return

	if corpos_em_cima == 0 and ativo:
		desativar()
		for alvo in alvos:
			if is_instance_valid(alvo):
				alvo.call("desativar")

func _algum_alvo_ativo() -> bool:
	for alvo in alvos:
		if is_instance_valid(alvo) and alvo.has_method("get_ativo"):
			if alvo.call("get_ativo"):
				return true
	return false

func _ao_ativar():
	if anim:
		anim.play("ativado")

func _ao_desativar():
	if anim:
		anim.play("desativado")
