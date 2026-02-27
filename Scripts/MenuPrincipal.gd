extends Control

func _on_botaoJogar_pressed():
	GameManager.IniciarJogo()
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_botaoSair_pressed():
	get_tree().quit()
