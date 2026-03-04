extends Control
class_name OpcoesAudioUI

@export var s_master: HSlider
@export var s_bgm: HSlider
@export var s_sfx: HSlider

func _ready():
	s_master.value = AudioManager.master
	s_bgm.value = AudioManager.bgm
	s_sfx.value = AudioManager.sfx

	s_master.value_changed.connect(func(v):
		AudioManager.set_master(v)
	)

	s_bgm.value_changed.connect(func(v):
		AudioManager.set_bgm(v)
	)

	s_sfx.value_changed.connect(func(v):
		AudioManager.set_sfx(v)
	)
