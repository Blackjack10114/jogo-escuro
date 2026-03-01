class_name Altar
extends Ativavel

@export var cor_aceita: Cor.Tipo
@export var textura_desativado: Texture2D
@export var textura_ativado: Texture2D

@onready var sprite: Sprite2D = $Sprite2D

var player_perto: CharacterBody2D = null
var tocha_no_altar = null
var bloqueado := false


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	sprite.texture = textura_desativado


func _on_body_entered(body):
	if body is CharacterBody2D:
		player_perto = body


func _on_body_exited(body):
	if body == player_perto:
		player_perto = null


func _process(_delta):
	if bloqueado:
		return
		
	if player_perto and Input.is_action_just_pressed("ui_accept"):
		if ativo:
			remover_tocha()
		else:
			colocar_tocha()


func aceita_cor(cor_tocha):
	return cor_aceita == Cor.Tipo.NEUTRO or cor_tocha == cor_aceita


func colocar_tocha():
	if not player_perto:
		return
		
	if player_perto.tocha_atual == null:
		return
		
	var tocha = player_perto.tocha_atual
	
	if not aceita_cor(tocha.cor):
		tocha.voltar_para_chao()
		return
	
	player_perto.remove_child(tocha)
	add_child(tocha)
	tocha.position = Vector2.ZERO
	
	tocha.carregada = false
	player_perto.tocha_atual = null
	
	tocha_no_altar = tocha
	tocha.altar_atual = self
	
	ativar()  


func remover_tocha():
	if not ativo:
		return
		
	if not player_perto:
		return
		
	if player_perto.tocha_atual != null:
		return
		
	if not tocha_no_altar:
		return
	
	remove_child(tocha_no_altar)
	player_perto.add_child(tocha_no_altar)
	tocha_no_altar.position = Vector2(20, 0)
	
	tocha_no_altar.carregada = true
	player_perto.tocha_atual = tocha_no_altar
	
	tocha_no_altar.altar_atual = null
	tocha_no_altar = null
	
	desativar() 

func _ao_ativar():
	sprite.texture = textura_ativado


func _ao_desativar():
	sprite.texture = textura_desativado 
