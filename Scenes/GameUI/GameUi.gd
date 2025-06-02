extends Control

@onready var game_over_label: Label = $GameOverLabel
@onready var press_space_label: Label = $PressSpaceLabel
@onready var timer: Timer = $Timer


var _can_press: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit"):
		GameManager.load_main_scene()
	elif _can_press == true and event.is_action_pressed("jump"):
		GameManager.load_main_scene()

func _enter_tree() -> void:
	SignalHub.on_plane_died.connect(on_plane_died)


func on_plane_died() -> void:
	game_over_label.show()
	timer.start()


func _on_timer_timeout() -> void:
	_can_press = true
	game_over_label.hide()
	press_space_label.show()
