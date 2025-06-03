extends Control


const GAME_OVER = preload("res://assets/audio/game_over.wav")


@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var game_over_label: Label = $GameOverLabel
@onready var press_space_label: Label = $PressSpaceLabel
@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer = $Sound


var _can_press: bool = false
var _score: int = 0


func _ready() -> void:
	_score = 0
	


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit"):
		GameManager.load_main_scene()
	elif _can_press == true and event.is_action_pressed("jump"):
		ScoreManager.high_score = _score
		GameManager.load_main_scene()

func _enter_tree() -> void:
	SignalHub.on_point_scored.connect(on_point_scored)
	SignalHub.on_plane_died.connect(on_plane_died) 


func on_plane_died() -> void:
	sound.stop()
	sound.stream = GAME_OVER
	sound.play()
	game_over_label.show()
	timer.start()

func on_point_scored() -> void:
	sound.play()
	_score += 1
	score_label.text = "%04d" % _score

func _on_timer_timeout() -> void:
	_can_press = true
	game_over_label.hide()
	press_space_label.show()
