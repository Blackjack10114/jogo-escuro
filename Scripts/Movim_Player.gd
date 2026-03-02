extends CharacterBody2D

@export var speed := 500.0

var forca_externa: Vector2 = Vector2.ZERO
var esta_na_sombra: bool = false

func empurrar(direcao: Vector2, forca: float):
	forca_externa += direcao.normalized() * forca

func _physics_process(_delta):
	var direction := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	var movimento_input = direction * speed
	
	velocity = movimento_input + forca_externa
	move_and_slide()
	
	# 🔥 Zera só se NÃO estiver na sombra
	if not esta_na_sombra:
		forca_externa = Vector2.ZERO

	_empurrar_caixas(direction)

func _empurrar_caixas(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		return

	for i in range(get_slide_collision_count()):
		var col := get_slide_collision(i)
		var obj := col.get_collider()

		if obj is CaixaSimples:
			var normal := col.get_normal()
			
			# Só empurra se estiver pressionando contra a face da caixa
			if direction.dot(-normal) > 0.7:
				(obj as CaixaSimples).empurrar(direction)
