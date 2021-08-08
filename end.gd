extends Node2D

var done : bool = true

func _ready():
	$timer.one_shot = true
	$timer.start(4)
	
func _process(delta):
	if $timer.is_stopped() and done:
		done = false
		var end_dialog = Dialogic.start("end", false)
		end_dialog.connect("timeline_end", self, "dialog_end")
		add_child(end_dialog)
