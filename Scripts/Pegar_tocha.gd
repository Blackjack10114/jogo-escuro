extends Area2D

var pode_pegar = false
var player = null

func _ready():
	connect("body_entered", _on_body_entered)
	#connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body is CharacterBody2D:
		print ("colidiu com player")
		pode_pegar = true
		player = body

func _on_body_exited(body):
	if body is CharacterBody2D:
		pode_pegar = false
		player = null

func _process(_delta):
	if pode_pegar and Input.is_action_just_pressed("ui_accept"):
		pegar_tocha()

func pegar_tocha():
	if player:
		get_parent().remove_child(self)
		player.add_child(self)
		position = Vector2(20, 0)
		player.tocha = self
