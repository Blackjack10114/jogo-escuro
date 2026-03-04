extends Control

func _ready():
	$Controles.visible = false


func _on_botaoJogar_pressed():
	GameManager.IrParaJogo("res://Scenes/SceneTeste/Hugo.tscn")


func _on_botaoControles_pressed():
	$Controles.visible = true


func _on_botaoCreditos_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Creditos.tscn")


func _on_botaoSair_pressed():
	get_tree().quit()


func _on_botaoVoltarControles_pressed():
	$Controles.visible = false
