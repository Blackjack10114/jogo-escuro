class_name AutoCaixa
extends Path2D

@export var velocidade := 120.0

@onready var follow: PathFollow2D = $PathFollow2D
@onready var sprite: Sprite2D = $PathFollow2D/Caixa/Sprite2D
@onready var impacto: Area2D = $PathFollow2D/Caixa/Impacto

var ativa := false
var terminou := false
var quebrou := false

func _ready():
	follow.progress = 0.0
	impacto.body_entered.connect(_on_impacto)
	impacto.area_entered.connect(_on_impacto)
	impacto.monitoring = false  # só quebra quando estiver ativa

func ativar():
	if terminou or quebrou:
		return
	ativa = true
	impacto.monitoring = true

func desativar():
	ativa = false
	impacto.monitoring = false

func get_ativo() -> bool:
	return ativa and not terminou and not quebrou

func _physics_process(delta):
	if not ativa or terminou or quebrou:
		return

	follow.progress += velocidade * delta

	if follow.progress_ratio >= 1.0:
		terminou = true
		ativa = false
		impacto.monitoring = false  # no fim não quebra mais

func _on_impacto(_obj):
	if terminou or quebrou:
		return
	_quebrar()

func _quebrar():
	quebrou = true
	ativa = false
	impacto.monitoring = false
	
	if sprite:
		sprite.visible = false
