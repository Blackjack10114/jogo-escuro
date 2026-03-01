class_name BotaoLongTrigger
extends Ativavel

@export var alvos: Array[Node] = []
@export var trava_se_alvo_ativo := true

@onready var sprite: Sprite2D = get_node_or_null("Sprite2D")
var corpos_em_cima := 0

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	_set_estado(false)

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
		elif is_instance_valid(alvo) and ("ativo" in alvo):
			# fallback (às vezes funciona dependendo do tipo)
			if alvo.ativo:
				return true
	return false

func _ao_ativar():
	if sprite:
		sprite.modulate.a = 0.7

func _ao_desativar():
	if sprite:
		sprite.modulate.a = 1.0
