extends CharacterBody2D

@export var speed = 500
var color


func _physics_process(_delta):
	var direction = Vector2.ZERO
	
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	#direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#print (direction)
	#direction = direction.normalized()
	velocity = direction * speed
	
	move_and_slide()
