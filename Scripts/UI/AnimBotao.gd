extends Label

var tempo := 0.0

@export var intensidade := 0.05
@export var velocidade := 2.0

@export var escala_base := 1.0
@export var escala_intensidade := 0.1
@export var escala_velocidade := 2.0

func _process(delta):
	tempo += delta * velocidade
	
	# gangorra
	rotation = sin(tempo) * intensidade
	
	# pulsar tamanho
	var s = escala_base + sin(tempo * escala_velocidade) * escala_intensidade
	scale = Vector2(s, s)
