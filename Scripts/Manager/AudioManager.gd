extends Node

@export var musica_menu: AudioStream
@export var musica_jogo: AudioStream
@export var som_ambiente: AudioStream

@onready var music: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var ambience: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	add_child(music)
	add_child(ambience)

	music.bus = "BGM"
	ambience.bus = "Ambience"

	music.process_mode = Node.PROCESS_MODE_ALWAYS
	ambience.process_mode = Node.PROCESS_MODE_ALWAYS

	music.autoplay = false
	ambience.autoplay = false


# ---------- MUSIC ----------
func play_music(stream: AudioStream) -> void:
	if stream == null:
		return
	if music.stream == stream and music.playing:
		return
	music.stream = stream
	music.play()

func stop_music() -> void:
	music.stop()


# ---------- AMBIENCE ----------
func play_ambience(stream: AudioStream) -> void:
	if stream == null:
		return
	if ambience.stream == stream and ambience.playing:
		return
	ambience.stream = stream
	ambience.play()

func stop_ambience() -> void:
	ambience.stop()


# ---------- SFX (one-shot, não corta sons) ----------
func play_sfx(stream: AudioStream) -> void:
	if stream == null:
		return
	var p := AudioStreamPlayer.new()
	p.bus = "SFX"
	p.stream = stream
	p.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(p)
	p.play()
	p.finished.connect(p.queue_free)
