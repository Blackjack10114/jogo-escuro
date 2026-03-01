class_name Porta
extends StaticBody2D

@export var começa_aberta := false

# sprites
@export var sprite_fechada: Texture2D
@export var sprite_aberta: Texture2D

# animação (opcional)
@export var usar_animacao := false
@export var nome_anim_abrir := "abrir"
@export var nome_anim_fechar := "fechar"

@onready var colisao: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var animacao: AnimationPlayer = get_node_or_null("AnimationPlayer")

var aberta := false

func _ready():
	if começa_aberta:
		ativar()
	else:
		desativar()

func ativar() -> void:
	# abrir
	if aberta:
		return
	aberta = true

	if colisao:
		colisao.disabled = true

	if usar_animacao and animacao and animacao.has_animation(nome_anim_abrir):
		animacao.play(nome_anim_abrir)
	elif sprite and sprite_aberta:
		sprite.texture = sprite_aberta

	if sprite:
		sprite.modulate.a = 0.35

func desativar() -> void:
	# fechar
	if not aberta:
		return
	aberta = false

	if colisao:
		colisao.disabled = false

	if usar_animacao and animacao and animacao.has_animation(nome_anim_fechar):
		animacao.play(nome_anim_fechar)
	elif sprite and sprite_fechada:
		sprite.texture = sprite_fechada

	if sprite:
		sprite.modulate.a = 1.0

func alternar() -> void:
	if aberta:
		desativar()
	else:
		ativar()
func get_ativo() -> bool:
	return aberta
