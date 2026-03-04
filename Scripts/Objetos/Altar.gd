class_name Altar
extends Ativador

@export var cor_aceita: Cor.Tipo
@export var luz: PointLight2D


var player_perto: CharacterBody2D = null
var tocha_no_altar: TOCHA = null

func _ready():
	%looks.play("inactive")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body is CharacterBody2D:
		player_perto = body


func _on_body_exited(body):
	if body == player_perto:
		player_perto = null


func _physics_process(delta: float) -> void:
		
	if player_perto and Input.is_action_just_pressed("interact"):
		print(ativo)
		if ativo:
			remover_tocha()
		else:
			colocar_tocha()


func aceita_cor(cor_tocha):
	return cor_aceita == Cor.Tipo.NEUTRO or cor_tocha == cor_aceita


func colocar_tocha():
	if player_perto.tocha_atual == null:
		return
		
	var tocha = player_perto.tocha_atual
	
	if not aceita_cor(tocha.cor):
		return
	
	player_perto.remove_child(tocha)
	add_child(tocha)
	tocha.position = Vector2.ZERO
	tocha.visible = false
	
	tocha.carregada = false
	player_perto.tocha_atual = null
	
	tocha_no_altar = tocha
	luz.enabled = true
	ativar()  


func remover_tocha():
	if player_perto.tocha_atual != null:
		return
		
	if not tocha_no_altar:
		return
	
	tocha_no_altar.visible = true
	remove_child(tocha_no_altar)
	player_perto.add_child(tocha_no_altar)
	tocha_no_altar.position = Vector2(5, 0)
	
	tocha_no_altar.carregada = true
	player_perto.tocha_atual = tocha_no_altar
	
	tocha_no_altar = null
	
	luz.enabled = false
	desativar() 

func _ao_ativar():
	%looks.play("active")

func _ao_desativar():
	%looks.play("inactive")
