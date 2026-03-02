extends Node

@onready var music: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var ambience: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var sfx: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	add_child(music)
	add_child(ambience)
	add_child(sfx)

	music.bus = "Music"
	ambience.bus = "Ambience"
	sfx.bus = "SFX"

	music.process_mode = Node.PROCESS_MODE_ALWAYS
	ambience.process_mode = Node.PROCESS_MODE_ALWAYS
	sfx.process_mode = Node.PROCESS_MODE_ALWAYS

	music.autoplay = false
	ambience.autoplay = false


func play_music(stream: AudioStream, from_begin := true) -> void:
	if stream == null:
		return
	if music.stream == stream and music.playing:
		return
	music.stream = stream
	if from_begin:
		music.play()
	else:
		music.play(music.get_playback_position())


func stop_music() -> void:
	music.stop()


func play_ambience(stream: AudioStream) -> void:
	if stream == null:
		return
	if ambience.stream == stream and ambience.playing:
		return
	ambience.stream = stream
	ambience.play()


func stop_ambience() -> void:
	ambience.stop()


func play_sfx(stream: AudioStream) -> void:
	if stream == null:
		return
	sfx.stream = stream
	sfx.play()
