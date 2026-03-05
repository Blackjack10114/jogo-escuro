extends Control

@export var panel_menu: Control
@export var panel_opcoes: Control
@export var panel_controles: Control
@export var fade: ColorRect

@export var tempo_Fade := 5

func _ready():
	_mostrar_menu()

	if fade:
		fade.visible = true
		fade.modulate.a = 0.0

	if is_instance_valid(AudioManager):
		AudioManager.play_music(AudioManager.musica_menu)

func _mostrar_menu():
	panel_menu.visible = true
	panel_opcoes.visible = false
	panel_controles.visible = false

func _mostrar_opcoes():
	panel_menu.visible = false
	panel_opcoes.visible = true
	panel_controles.visible = false

func _mostrar_controles():
	panel_menu.visible = false
	panel_opcoes.visible = false
	panel_controles.visible = true

#---- botões do MENU principal ----
func _on_botaoJogar_pressed():
	if fade:
		var tw := create_tween()
		tw.tween_property(fade, "modulate:a", 1.0, 0.5)
		await tw.finished
	GameManager.IrParaJogo("res://Scenes/main_game.tscn")

func _on_botaoOpcoes_pressed():
	_mostrar_opcoes()

func _on_botaoCreditos_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Creditos.tscn")

func _on_botaoSair_pressed():
	get_tree().quit()

#---- botões do painel OPÇÕES ----
func _on_botaoVoltarOpcoes_pressed():
	_mostrar_menu()

func _on_botaoControlesOpcoes_pressed():
	_mostrar_controles()

#---- botão voltar do painel CONTROLES ----
func _on_botaoVoltarControles_pressed():
	_mostrar_opcoes()
