class_name AutoCaixa
extends Node2D

@export var velocidade := 120.0
@export var respawn_delay := 1.0

@onready var follow: PathFollow2D = $Path2D/PathFollow2D
@onready var caixa: Node2D = $Path2D/PathFollow2D/Caixa
@onready var impacto: Area2D = $Path2D/PathFollow2D/Caixa/Impacto

@onready var colisao_solida_node: Node = $Path2D/PathFollow2D/Caixa/ColisaoSolida
@onready var impacto_shape: CollisionShape2D = $Path2D/PathFollow2D/Caixa/Impacto/CollisionShape2D
@onready var solida_shape: CollisionShape2D = $Path2D/PathFollow2D/Caixa/ColisaoSolida/CollisionShape2D

var rodando := false
var quebrada := false
var terminou := false

func _ready() -> void:
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
	if rodando or quebrada:
		return

	# opcional: reativa mesmo se já tinha terminado
	#terminou = false

	rodando = true
	impacto.monitoring = true

func desativar() -> void:
	rodando = false
	if impacto:
		impacto.monitoring = false

func get_ativo() -> bool:
	return rodando

func _physics_process(delta: float) -> void:
	if not rodando or quebrada or terminou:
		return

	follow.progress += velocidade * delta

	if follow.progress_ratio >= 1.0:
		terminou = true
		rodando = false
		impacto.monitoring = false

func _on_impacto(body: Node) -> void:
	# Evita quebrar por auto-colisão (Impacto pegando o próprio corpo/colisão)
	if body == colisao_solida_node:
		return
	_tentar_quebrar()

func _on_impacto_area(area: Area2D) -> void:
	# Evita quebrar se detectar alguma Area2D que esteja dentro da própria caixa
	if caixa.is_ancestor_of(area):
		return
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

	# quando invisível, desliga shapes pra não colidir/detectar nada
	if impacto_shape:
		impacto_shape.disabled = not v
	if solida_shape:
		solida_shape.disabled = not v
