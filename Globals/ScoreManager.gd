extends Node


var _high_score: int = 0
var high_score: int:
	get:
		return _high_score
	set(value):
		if value > _high_score:
			_high_score = value

func _ready() -> void:
	pass
