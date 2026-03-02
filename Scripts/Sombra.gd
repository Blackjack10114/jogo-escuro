extends Area2D

@export var forca_empurrao: float = 3.0

var player: CharacterBody2D = null

func _on_body_entered(body):
	if body is CharacterBody2D:
		player = body
		player.esta_na_sombra = true
		print("Player entrou na sombra")

func _on_body_exited(body):
	if body == player:
		player.esta_na_sombra = false
		player = null
		print("Player saiu da sombra")

func _physics_process(_delta):
	if player:
		var direcao = player.global_position - global_position
		player.empurrar(direcao, forca_empurrao)
