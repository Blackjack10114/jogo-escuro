extends Area2D

@export var cor: Cor.Tipo

var pode_pegar = false
var player = null
var carregada = false
var posicao_original: Vector2
var altar_atual = null

func _ready():
	posicao_original = global_position
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body is CharacterBody2D and not carregada:
		pode_pegar = true
		player = body

func _on_body_exited(body):
	if body == player:
		pode_pegar = false
		player = null

func _process(_delta):
	if pode_pegar and Input.is_action_just_pressed("ui_accept"):
		pegar_tocha()

func pegar_tocha():
	if not player:
		return
		
	if not carregada and player.tocha_atual == null:
		
		var p = player  # guarda referência 
		
		get_parent().remove_child(self)
		p.add_child(self)
		
		position = Vector2(20, 0)
		carregada = true
		p.tocha_atual = self

func voltar_para_chao():
	if carregada:
		var p = get_parent()
		p.remove_child(self)
		get_tree().current_scene.add_child(self)
		global_position = posicao_original
		carregada = false
		p.tocha_atual = null
		altar_atual = null
