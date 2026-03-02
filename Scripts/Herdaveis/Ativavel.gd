class_name Ativavel
extends Area2D

signal ativado
signal desativado
signal estado_alterado(novo_estado: bool)

var ativo := false


func ativar():
	_set_estado(true)


func desativar():
	_set_estado(false)


func alternar():
	_set_estado(not ativo)


func _set_estado(valor: bool):
	if ativo == valor:
		return
		
	ativo = valor
	
	if ativo:
		_ao_ativar()
		ativado.emit()
	else:
		_ao_desativar()
		desativado.emit()

	estado_alterado.emit(ativo)


func _ao_ativar():
	pass

func _ao_desativar():
	pass
