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
var tocha = null
var pode_largar_no_altar = null
func _on_area_entered(area):
	if area.name == "Altar":
		pode_largar_no_altar = area

func _on_area_exited(area):
	if area.name == "Altar":
		pode_largar_no_altar = null

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if tocha and pode_largar_no_altar:
			largar_tocha()
func largar_tocha():
	if tocha:
		var altar = pode_largar_no_altar
		remove_child(tocha)
		altar.add_child(tocha)
		tocha.position = Vector2.ZERO
		tocha.z_index = 0
		tocha = null
