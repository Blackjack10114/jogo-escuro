extends Area2D

var player_dentro = null

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body is CharacterBody2D:
		player_dentro = body

func _on_body_exited(body):
	if body is CharacterBody2D:
		player_dentro = null
