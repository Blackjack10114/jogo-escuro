class_name Porta
extends StaticBody2D

@export var começa_aberta := false

# sprites
@export var sprite_fechada: Texture2D
@export var sprite_aberta: Texture2D

# animação futura (opcional)
@export var usar_animacao := false
@export var nome_anim_abrir := "abrir"
@export var nome_anim_fechar := "fechar"

var aberta := false

@onready var colisao: CollisionShape2D = get_node_or_null("CollisionShape2D")
@onready var sprite: Sprite2D = get_node_or_null("Sprite2D")
@onready var animacao: AnimationPlayer = get_node_or_null("AnimationPlayer")


func _ready():
	aberta = começa_aberta
	atualizar_estado(true)


func alternar():
	if aberta:
		fechar()
	else:
		abrir()


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


func atualizar_estado(inicial := false):
	if colisao:
		colisao.disabled = aberta
	else:
		print("ERRO: CollisionShape2D não encontrado na porta")

	# por animação
	if usar_animacao and animacao and not inicial:
		if aberta and animacao.has_animation(nome_anim_abrir):
			animacao.play(nome_anim_abrir)
		elif not aberta and animacao.has_animation(nome_anim_fechar):
			animacao.play(nome_anim_fechar)
		return
	
	# por sprite
	if sprite:
		if aberta and sprite_aberta:
			sprite.texture = sprite_aberta
		elif not aberta and sprite_fechada:
			sprite.texture = sprite_fechada

		sprite.modulate.a = 0.35 if aberta else 1.0
