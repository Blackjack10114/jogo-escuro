extends Area2D
class_name FimTrigger

@export var cena_final: String = "res://Scenes/UI/CenaFinal.tscn"
var disparou := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if disparou:
		return
	if not body.is_in_group("player"):
		return

	disparou = true
	GameManager.IrParaCena(cena_final)
