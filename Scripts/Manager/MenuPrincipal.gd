extends Control

func _on_botaoJogar_pressed():
#	$Fade.FadeOut()
	#await get_tree().create_timer(0.4).timeout
	
	GameManager.IniciarJogo()
	#get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	#get_tree().change_scene_to_file("res://Scenes/SceneTeste/Gabriel.tscn")
	get_tree().change_scene_to_file("res://Scenes/SceneTeste/Hugo.tscn")

func _on_botaoSair_pressed():
	get_tree().quit()
