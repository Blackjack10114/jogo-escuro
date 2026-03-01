extends CharacterBody2D

@export var speed := 500.0
var color
var tocha_atual = null

func _physics_process(_delta):
	var direction := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction * speed
	move_and_slide()

	_empurrar_caixas(direction)

func _empurrar_caixas(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		return

	for i in range(get_slide_collision_count()):
		var col := get_slide_collision(i)
		var obj := col.get_collider()
		if obj is CaixaSimples:
			(obj as CaixaSimples).empurrar(direction)
