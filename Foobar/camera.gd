extends Camera2D

const SPEED : int = 180

var moving : bool = false
var pos_to : int = 0
var traveled : int = 0

signal arrived

func _ready():
	pass
	
func _process(delta):
	if moving:
		if pos_to < position.y:
			position.y -= SPEED * delta
			traveled += SPEED * delta
			
			if traveled >= 400:
				moving = false
				position.y = pos_to
				emit_signal("arrived")
		elif pos_to > position.y:
			position.y += SPEED * delta
			traveled += SPEED * delta
			
			if traveled >= 400:
				moving = false
				position.y = pos_to
				emit_signal("arrived")
	
func move(direction : String) -> void:
	traveled = 0
	moving = true
	
	if direction == "up":
		pos_to = position.y - 600
	elif direction == "down":
		pos_to = position.y + 600
