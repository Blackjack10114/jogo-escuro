class_name AutoCaixa
extends Node2D

@export var velocidade := 120.0
@export var respawn_delay := 1.0

@onready var follow: PathFollow2D = $Path2D/PathFollow2D
@onready var caixa: Node2D = $Path2D/PathFollow2D/Caixa
@onready var sprite: Sprite2D = get_node_or_null("Path2D/PathFollow2D/Caixa/Sprite2D")
@onready var impacto: Area2D = get_node_or_null("Path2D/PathFollow2D/Caixa/Impacto")

var rodando := false
var quebrada := false
var terminou := false

func _ready():
	if not follow:
		push_error("AutoCaixa: nao achei Path2D/PathFollow2D")
		return
	if not caixa:
		push_error("AutoCaixa: nao achei Path2D/PathFollow2D/Caixa")
		return
	if not impacto:
		push_error("AutoCaixa: nao achei Impacto em Path2D/PathFollow2D/Caixa/Impacto")
		return

	follow.progress = 0.0
	rodando = false
	quebrada = false
	terminou = false

	impacto.body_entered.connect(_on_impacto)
	impacto.area_entered.connect(_on_impacto_area)
	impacto.monitoring = false

	_set_visivel(true)

func ativar() -> void:
	if rodando or terminou or quebrada:
		return

	rodando = true
	impacto.monitoring = true

func desativar() -> void:
	rodando = false
	if impacto:
		impacto.monitoring = false

func get_ativo() -> bool:
	return rodando

func _physics_process(delta):
	if not rodando or quebrada or terminou:
		return

	follow.progress += velocidade * delta

	if follow.progress_ratio >= 1.0:
		terminou = true
		rodando = false
		impacto.monitoring = false

func _on_impacto(_body: Node) -> void:
	_tentar_quebrar()

func _on_impacto_area(_area: Area2D) -> void:
	_tentar_quebrar()

func _tentar_quebrar() -> void:
	if not rodando or terminou or quebrada:
		return
	_quebrar_e_respawn()

func _quebrar_e_respawn() -> void:
	quebrada = true
	rodando = false
	impacto.monitoring = false

	_set_visivel(false)

	await get_tree().create_timer(respawn_delay).timeout

	follow.progress = 0.0

	_set_visivel(true)
	quebrada = false

func _set_visivel(v: bool) -> void:
	if caixa:
		caixa.visible = v
