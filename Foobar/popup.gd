extends AnimatedSprite

var pop_pop : bool = false
export var active : bool = true

signal interacted

func _ready():
	hide()
	$area.connect("body_entered", self, "popup")
	$area.connect("body_exited", self, "popdown")
	self.connect("frame_changed", self, "frame0")
	
func _process(delta):
	pass
	
func interacted() -> void:
	if active:
		emit_signal("interacted")
	
func popup(body) -> void:
	if active:
		frame = 0
		pop_pop = true
		show()
		play("popup")
	
func popdown(body) -> void:
	pop_pop = false
	if frame == 4:
		play("popup", true)
	else:
		hide()
		
func frame0() -> void:
	if frame == 0:
		hide()
