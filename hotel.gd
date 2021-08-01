extends Node2D

const rotate_puzzle = preload("res://Foobar/rotate_puzzle.tscn")

var elevating : bool = false
var getting_in : bool = false
var met_phil : bool = false
var fading : bool = false
var unfading : bool = false
var touched : bool = false
var kylie_convo : int = 0
var floor_on : int = 0
var pistachio_pos : Vector2 = Vector2(0, 0)
var rotate_puzzle_orientation : int = 0
var hole_1 : String = "NULL"
var hole_2 : String = "NULL"
var color : String = "NULL"

func _ready():
	$camera.make_current()
	$camera.connect("arrived", self, "elevator_arrived")
	
	$popups/elevator1b.connect("interacted", self, "elevator1b_e")
	$popups/elevator0.connect("interacted", self, "elevator0_e")
	$popups/elevator1.connect("interacted", self, "elevator1_e")
	$popups/elevator2.connect("interacted", self, "elevator2_e")
	$popups/krita_kylie.connect("interacted", self, "kylie_e")
	$popups/room_202.connect("interacted", self, "room_202_e")
	$popups/floor_2.connect("interacted", self, "floor_2_e")
	$popups/bathroom.connect("interacted", self, "bathroom_e")
	$popups/bed.connect("interacted", self, "bed_e")
	$popups/blast.connect("interacted", self, "blast_e")
	$popups/rotate_puzzle.connect("interacted", self, "rotate_puzzle_e")
	$popups/sketchy_door.connect("interacted", self, "sketchy_door_e")
	$popups/door_106.connect("interacted", self, "door_106_e")
	$popups/room_106.connect("interacted", self, "room_106_e")
	
	$root_mspm.connect("interact", self, "interacted")
	
func _process(delta):
	if elevating:
		if Input.is_action_just_pressed("up"):
			if floor_on < 2:
				$camera.move("up")
				floor_on += 1
				elevating = false
		elif Input.is_action_just_pressed("down"):
			if floor_on > -1:
				$camera.move("down")
				floor_on -= 1
				elevating = false
		elif Input.is_action_just_pressed("interact"):
			get_off_elevator()
			
	if fading:
		$modLayer/fade.modulate.a += 0.05
		
		if $modLayer/fade.modulate.a >= 1.0:
			fading = false
			unfading = true
	elif unfading:
		$modLayer/fade.modulate.a -= 0.05
		
		if $modLayer/fade.modulate.a <= 0.0:
			$modLayer/fade.modulate.a = 0
			unfading = false
	
	if !$camera.moving:
		match floor_on:
			-1:
				$camera.position.x = $root_mspm.position.x - 512
				if $camera.position.x < 0:
					$camera.position.x = 0
			0:
				$camera.position.x = 0
			1:
				$camera.position.x = $root_mspm.position.x - 512
				if $camera.position.x > 0:
					$camera.position.x = 0
			2:
				if $root_mspm.position.x < 1024:
					$camera.position.x = $root_mspm.position.x - 512
					if $camera.position.x > 0:
						$camera.position.x = 0
				else:
					$camera.position.x = 1024
			3:
				pass
	
func interacted() -> void:
	for child in $popups.get_children():
		if child.pop_pop:
			child.interacted()
			
func kylie_e() -> void:
	if kylie_convo == 5:
		$root_mspm.talking = true
		$popups/krita_kylie.hide()
		var kylie_dialog = Dialogic.start("krita_kylie_4", false)
		kylie_dialog.connect("timeline_end", self, "dialog_end")
		kylie_convo = 6
		$popups/krita_kylie.active = false
		$canvasLayer.add_child(kylie_dialog)
	if kylie_convo == 4:
		$root_mspm.talking = true
		$popups/krita_kylie.hide()
		var kylie_dialog = Dialogic.start("krita_kylie_3", false)
		kylie_dialog.connect("timeline_end", self, "dialog_end")
		kylie_convo = 5
		$popups/krita_kylie.active = true
		$canvasLayer.add_child(kylie_dialog)
	elif met_phil:
		$root_mspm.talking = true
		$popups/krita_kylie.hide()
		var kylie_dialog = Dialogic.start("krita_kylie_2", false)
		kylie_dialog.connect("timeline_end", self, "dialog_end")
		kylie_convo = 3
		$blast/particles0.show()
		$blast/particles1.show()
		$blast/particles2.show()
		$popups/blast.active = true
		$popups/bed.active = false
		$popups/krita_kylie.active = false
		$canvasLayer.add_child(kylie_dialog)
	else:
		$root_mspm.talking = true
		$popups/krita_kylie.hide()
		var kylie_dialog = Dialogic.start("krita_kylie_1", false)
		kylie_dialog.connect("timeline_end", self, "dialog_end")
		kylie_convo = 2
		$popups/krita_kylie.active = false
		$canvasLayer.add_child(kylie_dialog)
	
func room_202_e() -> void:
	if kylie_convo >= 2:
		$root_mspm.position = $popups/room_202/pos.global_position
	else:
		$root_mspm.talking = true
		$popups/room_202.hide()
		var room_dialog = Dialogic.start("locked", false)
		room_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(room_dialog)
	
func floor_2_e() -> void:
	$root_mspm.position = $popups/floor_2/pos.global_position
	
func bathroom_e() -> void:
	$root_mspm.talking = true
	$popups/bathroom.hide()
	var bathroom_dialog = Dialogic.start("bathroom", false)
	bathroom_dialog.connect("timeline_end", self, "dialog_end")
	$canvasLayer.add_child(bathroom_dialog)
	
func bed_e() -> void:
	$root_mspm.talking = true
	$popups/bed.hide()
	var bed_dialog = Dialogic.start("bed_1", false)
	bed_dialog.connect("timeline_end", self, "dialog_end")
	bed_dialog.connect("dialogic_signal", self, "dialogical")
	$popups/bed.active = false
	$canvasLayer.add_child(bed_dialog)
	
func blast_e() -> void:
	if !touched:
		$root_mspm.talking = true
		$popups/blast.hide()
		var blast_dialog = Dialogic.start("blast", false)
		blast_dialog.connect("timeline_end", self, "dialog_end")
		blast_dialog.connect("dialogic_signal", self, "dialogical")
		touched = true
		$popups/bed.active = false
		$canvasLayer.add_child(blast_dialog)
	else:
		match hole_1:
			"red":
				hole_1 = "green"
			"green":
				hole_1 = "blue"
			"blue":
				hole_1 = "red"
				
		set_color()
		
func rotate_puzzle_e() -> void:
	var puzzle = rotate_puzzle.instance()
	puzzle.color = color
	puzzle.apply_color()
	puzzle.connect("exit", self, "puzzle_exit")
	puzzle.connect("solved", self, "puzzle_solved")
	$root_mspm.talking = true
	$canvasLayer.add_child(puzzle)
	
func sketchy_door_e() -> void:
	$root_mspm.position = $popups/sketchy_door/pos.global_position
	
func door_106_e() -> void:
	$root_mspm.position = $popups/door_106/pos.global_position
	
func room_106_e() -> void:
	$root_mspm.position = $popups/room_106/pos.global_position
	
func elevator1b_e() -> void:
	getting_in = true
	$root_mspm.talking = true
	$popups/elevator1b.hide()
	$elevator1b.play("open")
	
func elevator0_e() -> void:
	if kylie_convo == 0:
		$root_mspm.talking = true
		$popups/elevator0.hide()
		var kylie_dialog = Dialogic.start("kylie_0", false)
		kylie_convo = 1
		kylie_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(kylie_dialog)
	else:
		getting_in = true
		$root_mspm.talking = true
		$popups/elevator0.hide()
		$elevator0.play("open")
	
func elevator1_e() -> void:
	getting_in = true
	$root_mspm.talking = true
	$popups/elevator1.hide()
	$elevator1.play("open")
	
func elevator2_e() -> void:
	getting_in = true
	$root_mspm.talking = true
	$popups/elevator2.hide()
	$elevator2.play("open")
	
func elevator_arrived() -> void:
	elevating = true
	
	match floor_on:
		-1:
			$elevator1b/keys.show()
		0:
			$elevator0/keys.show()
		1:
			$elevator1/keys.show()
		2:
			$elevator2/keys.show()
			
func get_off_elevator() -> void:
	getting_in = false
	elevating = false
	
	$elevator1b/keys.hide()
	$elevator0/keys.hide()
	$elevator1/keys.hide()
	$elevator2/keys.hide()
	
	match floor_on:
		-1:
			$root_mspm.position.y = $elevator1b/pos.global_position.y
			$elevator1b.play("open")
		0:
			$root_mspm.position.y = $elevator0/pos.global_position.y
			$elevator0.play("open")
		1:
			$root_mspm.position.y = $elevator1/pos.global_position.y
			$elevator1.play("open")
		2:
			$root_mspm.position.y = $elevator2/pos.global_position.y
			$elevator2.play("open")
	
func dialog_end(timeline_name) -> void:
	$root_mspm.talking = false
	
func dialogical(argument) -> void:
	match argument:
		"blast":
			$blast.show()
			met_phil = true
			$popups/krita_kylie.active = true
			# blast_sfx.play()
			# screen shaek?
		"touch":
			hole_1 = "red"
			set_color()
			kylie_convo = 4
			$popups/krita_kylie.active = true
			# shaek()
			# rumble.play()
		"fade":
			$modLayer/fade.color = Color(0, 0, 0, 0)
			$modLayer/fade.modulate.a = 0
			fading = true
			
func set_color() -> void:
	if hole_1 == "red":
		if hole_2 == "NULL" or hole_2 == "red":
			$modLayer/colorRect.color = Color(255, 0, 0, 0.5)
			color = "red"
		elif hole_2 == "green":
			$modLayer/colorRect.color = Color(255, 255, 0, 0.5)
			color = "yellow"
		elif hole_2 == "blue":
			$modLayer/colorRect.color = Color(255, 0, 255, 0.5)
			color = "purple"
	elif hole_1 == "green":
		if hole_2 == "NULL" or hole_2 == "green":
			$modLayer/colorRect.color = Color(0, 255, 0, 0.5)
			color = "green"
		elif hole_2 == "red":
			$modLayer/colorRect.color = Color(255, 255, 0, 0.5)
			color = "yellow"
		elif hole_2 == "blue":
			$modLayer/colorRect.color = Color(0, 255, 255, 0.5)
			color = "teal"
	elif hole_1 == "blue":
		if hole_2 == "NULL" or hole_2 == "blue":
			$modLayer/colorRect.color = Color(0, 0, 255, 0.5)
			color = "blue"
		elif hole_2 == "red":
			$modLayer/colorRect.color = Color(255, 0, 255, 0.5)
			color = "purple"
		elif hole_2 == "green":
			$modLayer/colorRect.color = Color(0, 255, 255, 0.5)
			
	for child in $red_walls.get_children():
		child.disabled = false
	for child in $green_walls.get_children():
		child.disabled = false
	for child in $blue_walls.get_children():
		child.disabled = false
	for child in $yellow_walls.get_children():
		child.disabled = false
	for child in $teal_walls.get_children():
		child.disabled = false
	for child in $purple_walls.get_children():
		child.disabled = false
			
	match color:
		"red":
			for child in $red_walls.get_children():
				child.disabled = true
		"green":
			for child in $green_walls.get_children():
				child.disabled = true
		"blue":
			for child in $blue_walls.get_children():
				child.disabled = true
		"yellow":
			for child in $yellow_walls.get_children():
				child.disabled = true
		"teal":
			for child in $teal_walls.get_children():
				child.disabled = true
		"purple":
			for child in $purple_walls.get_children():
				child.disabled = true
				
func puzzle_exit() -> void:
	var array = $canvasLayer/rotate_puzzle.exit()
	pistachio_pos = array[0]
	rotate_puzzle_orientation = array[1]
	$canvasLayer.remove_child($canvasLayer/rotate_puzzle)
	$canvasLayer.queue_free()
	
func puzzle_solved() -> void:
	$canvasLayer.remove_child($canvasLayer/rotate_puzzle)
	$canvasLayer.queue_free()
	$popups/rotate_puzzle.active = false
	$root_mspm.talking = true
	var puzzle_dialog = Dialogic.start("puzzle_solved", false)
	puzzle_dialog.connect("timeline_end", self, "dialog_end")
	$canvasLayer.add_child(puzzle_dialog)
	
func _on_elevator0_frame_changed():
	if $elevator0.frame == 6:
		if getting_in:
			$root_mspm.z_index = 0
		else:
			$root_mspm.z_index = 1
			$root_mspm.talking = false
		$elevator0.play("open", true)
	elif $elevator0.frame == 0:
		if getting_in:
			elevating = true
			$elevator0.stop()
			$elevator0/keys.show()
		
func _on_elevator1_frame_changed():
	if $elevator1.frame == 6:
		if getting_in:
			$root_mspm.z_index = 0
		else:
			$root_mspm.z_index = 1
			$root_mspm.talking = false
		$elevator1.play("open", true)
	elif $elevator1.frame == 0:
		if getting_in:
			elevating = true
			$elevator1.stop()
			$elevator1/keys.show()
	
func _on_elevator2_frame_changed():
	if $elevator2.frame == 6:
		if getting_in:
			$root_mspm.z_index = 0
		else:
			$root_mspm.z_index = 1
			$root_mspm.talking = false
		$elevator2.play("open", true)
	elif $elevator2.frame == 0:
		if getting_in:
			elevating = true
			$elevator2.stop()
			$elevator2/keys.show()
	
func _on_elevator1b_frame_changed():
	if $elevator1b.frame == 6:
		if getting_in:
			$root_mspm.z_index = 0
		else:
			$root_mspm.z_index = 1
			$root_mspm.talking = false
		$elevator1b.play("open", true)
	elif $elevator1b.frame == 0:
		if getting_in:
			elevating = true
			$elevator1b.stop()
			$elevator1b/keys.show()
