extends Node

@export var musica_menu: AudioStream
@export var musica_jogo: AudioStream

@onready var music: AudioStreamPlayer = AudioStreamPlayer.new()

const SAVE_PATH := "user://audio.cfg"

func _ready() -> void:
	add_child(music)
	music.bus = "BGM"
	music.process_mode = Node.PROCESS_MODE_ALWAYS

	_load_volumes()
	_apply_volumes()


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


# ---------- SFX ----------
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


# ---------- VOLUME SETTINGS ----------
var master := 1.0
var bgm := 1.0
var sfx := 1.0

func set_master(v: float) -> void:
	master = v
	_apply_volumes()
	_save_volumes()

func set_bgm(v: float) -> void:
	bgm = v
	_apply_volumes()
	_save_volumes()

func set_sfx(v: float) -> void:
	sfx = v
	_apply_volumes()
	_save_volumes()

func _apply_volumes() -> void:
	_set_bus_linear("Master", master)
	_set_bus_linear("BGM", bgm)
	_set_bus_linear("SFX", sfx)

func _set_bus_linear(bus_name: String, linear: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1:
		return
	AudioServer.set_bus_volume_db(idx, linear_to_db(max(linear, 0.0001)))
	AudioServer.set_bus_mute(idx, linear <= 0.0001)

func _save_volumes() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("audio", "master", master)
	cfg.set_value("audio", "bgm", bgm)
	cfg.set_value("audio", "sfx", sfx)
	cfg.save(SAVE_PATH)

func _load_volumes() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) != OK:
		return
	master = float(cfg.get_value("audio", "master", 1.0))
	bgm = float(cfg.get_value("audio", "bgm", 1.0))
	sfx = float(cfg.get_value("audio", "sfx", 1.0))
