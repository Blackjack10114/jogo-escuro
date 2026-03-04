extends CharacterBody2D

@export var speed := 500.0

var forca_externa: Vector2 = Vector2.ZERO
var esta_na_sombra: bool = false
var color = null
var tocha_atual = null
var ultima_direcao: Vector2 = Vector2.DOWN

@onready var looks: AnimatedSprite2D = get_node_or_null("%looks")

func empurrar(direcao: Vector2, forca: float) -> void:
	forca_externa += direcao.normalized() * forca

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var movimento_input := direction * speed

	velocity = movimento_input + forca_externa
	move_and_slide()

	_atualizar_animacao(direction)
	if not esta_na_sombra:
		forca_externa = Vector2.ZERO

	_empurrar_caixas(direction)

func _atualizar_animacao(direction: Vector2) -> void:
	if looks == null:
		return
	if direction != Vector2.ZERO:
		ultima_direcao = direction

	if abs(ultima_direcao.x) > abs(ultima_direcao.y):
		looks.animation = "andando_lado"
		looks.flip_h = ultima_direcao.x < 0
	elif ultima_direcao.y < 0:
		looks.animation = "Andando_Cima"
	else:
		looks.animation = "idle"

func _set_anim(nome: String) -> void:
	if looks == null:
		return
	if looks.animation != nome:
		looks.play(nome)

func _empurrar_caixas(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		return

	for i in range(get_slide_collision_count()):
		var col := get_slide_collision(i)
		var obj := col.get_collider()

		if obj is CaixaSimples:
			var normal := col.get_normal()

			if direction.dot(-normal) > 0.7:
				(obj as CaixaSimples).empurrar(direction)
