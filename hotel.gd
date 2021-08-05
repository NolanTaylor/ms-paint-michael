extends Node2D

const rotate_puzzle = preload("res://Foobar/rotate_puzzle.tscn")
const shake_puzzle = preload("res://Foobar/shake_puzzle.tscn")

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

var elevating : bool = false
var getting_in : bool = false
var met_phil : bool = false
var met_phil_2 : bool = false
var met_alex : bool = false
var met_gilbert : bool = false
var met_natalie : bool = false
var fading : bool = false
var unfading : bool = false
var touched : bool = false
var portal : bool = false
var portal_2 : bool = false
var key : bool = false
var flip_left : bool = false
var flip_right : bool = false
var clockwise : bool = false
var counterclockwise : bool = false
var pistachio_portal : bool = false
var kylie_clues : bool = false
var alex_clues : bool = false
var gilbert_clues : bool = false
var natalie_clues : bool = false
var natalie_clues_all : bool = false
var gareth_talked : bool = false
var gareth_puzzle_solved : bool = false
var pistachioed : bool = false
var kylie_pistachio : bool = false
var gilbert_pistachio : bool = false
var pistachio_pile_1 : bool = true
var pistachio_bags : int = 0
var kylie_convo : int = 0
var floor_on : int = 0
var pistachio_pos : Vector2 = Vector2(-178, -192)
var rotate_puzzle_orientation : int = 0
var target_orientation : int = 0
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
	$popups/blast_2.connect("interacted", self, "blast_2_e")
	$popups/rotate_puzzle.connect("interacted", self, "rotate_puzzle_e")
	$popups/sketchy_door.connect("interacted", self, "sketchy_door_e")
	$popups/sketchy_wc.connect("interacted", self, "sketchy_wc_e")
	$popups/door_106.connect("interacted", self, "door_106_e")
	$popups/room_106.connect("interacted", self, "room_106_e")
	$popups/room_101.connect("interacted", self, "room_101_e")
	$popups/door_101.connect("interacted", self, "door_101_e")
	$popups/wc_101.connect("interacted", self, "wc_101_e")
	$popups/wc_304.connect("interacted", self, "wc_304_e")
	$popups/room_304.connect("interacted", self, "room_304_e")
	$popups/door_304.connect("interacted", self, "door_304_e")
	$popups/room_401.connect("interacted", self, "room_401_e")
	$popups/door_401.connect("interacted", self, "door_401_e")
	$popups/wc_401.connect("interacted", self, "wc_401_e")
	$popups/room_205.connect("interacted", self, "room_205_e")
	$popups/door_205.connect("interacted", self, "door_205_e")
	$popups/stairs_200.connect("interacted", self, "stairs_200_e")
	$popups/stairs_300_0.connect("interacted", self, "stairs_300_0_e")
	$popups/stairs_300_1.connect("interacted", self, "stairs_300_1_e")
	$popups/stairs_400.connect("interacted", self, "stairs_400_e")
	$popups/gareth.connect("interacted", self, "gareth_e")
	$popups/blenders.connect("interacted", self, "blenders_e")
	$popups/alex.connect("interacted", self, "alex_e")
	$popups/gilbert.connect("interacted", self, "gilbert_e")
	$popups/natalie.connect("interacted", self, "natalie_e")
	$popups/kylie_shake.connect("interacted", self, "kylie_shake_e")
	$popups/kylie_sad.connect("interacted", self, "kylie_sad_e")
	$popups/error.connect("interacted", self, "error_e")
	$popups/button_left.connect("interacted", self, "button_left_e")
	$popups/button_right.connect("interacted", self, "button_right_e")
	$popups/ladder.connect("interacted", self, "ladder_e")
	$popups/ladder_down.connect("interacted", self, "ladder_down_e")
	$popups/room_306.connect("interacted", self, "room_306_e")
	$popups/door_306.connect("interacted", self, "door_306_e")
	$popups/wc_306.connect("interacted", self, "wc_306_e")
	$popups/room_403.connect("interacted", self, "room_403_e")
	$popups/door_403.connect("interacted", self, "door_403_e")
	$popups/room_501.connect("interacted", self, "room_501_e")
	$popups/door_501.connect("interacted", self, "door_501_e")
	$popups/roof.connect("interacted", self, "roof_e")
	$key/key_pop.connect("interacted", self, "pick_up_key")
	
	$root_mspm.connect("interact", self, "interacted")
	
func _process(delta):
	# testing:

	if Input.is_action_just_pressed("exit"):
		$root_mspm.position = get_global_mouse_position()
	if Input.is_action_just_pressed("ui_home"):
		drop_key()
	if Input.is_action_just_pressed("ui_focus_next"):
		match color:
			"red":
				hole_1 = "green"
				$blast/particles0.color = Color(0, 1, 0)
				$blast/particles1.color = Color(0, 1, 0)
				$blast/particles2.color = Color(0, 1, 0)
			"green":
				hole_1 = "blue"
				$blast/particles0.color = Color(0, 0, 1)
				$blast/particles1.color = Color(0, 0, 1)
				$blast/particles2.color = Color(0, 0, 1)
			"blue":
				hole_1 = "red"
				$blast/particles0.color = Color(1, 0, 0)
				$blast/particles1.color = Color(1, 0, 0)
				$blast/particles2.color = Color(1, 0, 0)
			"NULL":
				color = "red"

		set_color()
	
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
			
	if key:
		$key.position.x = lerp( \
			$key.position.x, $root_mspm.position.x - 20, 0.025)
		$key.position.y = lerp( \
			$key.position.y, $root_mspm.position.y - 120, 0.025)
			
	if clockwise:
		$turvy.rotation_degrees += 180 * delta
		
		if $turvy.rotation_degrees >= target_orientation:
			$turvy.rotation_degrees = target_orientation
			while int($turvy.rotation_degrees) % 90 != 0:
				$turvy.rotation_degrees -= 1
			target_orientation = 0
			clockwise = false
			$root_mspm.position.y = -1912
			if $root_mspm.position.x < -250:
				match color:
					"red":
						if abs($turvy.rotation_degrees) == 180:
							fall()
					"green":
						if $turvy.rotation_degrees == -90:
							fall()
					"blue":
						if $turvy.rotation_degrees == 90:
							fall()
	elif counterclockwise:
		$turvy.rotation_degrees -= 180 * delta
		
		if $turvy.rotation_degrees <= target_orientation:
			$turvy.rotation_degrees = target_orientation
			while int($turvy.rotation_degrees) % 90 != 0:
				$turvy.rotation_degrees -= 1
			target_orientation = 0
			counterclockwise = false
			$root_mspm.position.y = -1912
			if $root_mspm.position.x < -250:
				match color:
					"red":
						if abs($turvy.rotation_degrees) == 180:
							fall()
					"green":
						if $turvy.rotation_degrees == -90:
							fall()
					"blue":
						if $turvy.rotation_degrees == 90:
							fall()
			
	if fading:
		$modLayer/fade.color.a += 0.5 * delta
		
		if $modLayer/fade.color.a >= 1.0:
			fading = false
			unfading = true
	elif unfading:
		$modLayer/fade.color.a -= 0.5 * delta
		
		if $modLayer/fade.color.a <= 0.0:
			$modLayer/fade.color.a = 0
			unfading = false
	
	if !$camera.moving:
		if floor_on == -1:
			$camera.position.y = 600
			$camera.position.x = $root_mspm.position.x - 512
			if $camera.position.x < 0:
				$camera.position.x = 0
			if $camera.position.x > 1024:
				$camera.position.x = 1024
		elif floor_on == 0:
			$camera.position = Vector2(0, 0)
		else:
			$camera.position.y = -(floor_on * 600)
			if $root_mspm.position.x < 1024:
				$camera.position.x = $root_mspm.position.x - 512
				if $camera.position.x > 0:
					$camera.position.x = 0
				elif $camera.position.x < -1332:
					$camera.position.x = -1332
			else:
				if $root_mspm.position.x > 2150:
					$camera.position.x = 2175
				else:
					$camera.position.x = 1024
	
func interacted() -> void:
	if $key/key_pop.pop_pop and $key/key_pop.active:
		$key/key_pop.interacted()
	else:
		for child in $popups.get_children():
			if child.pop_pop:
				child.interacted()
			
func kylie_e() -> void:
	$root_mspm.talking = true
	$popups/krita_kylie.hide()
	var kylie_dialog
	if kylie_convo == 6:
		kylie_dialog = Dialogic.start("kylie_5", false)
		key = true
		$key.show()
		kylie_convo = 7
	elif kylie_pistachio:
		kylie_dialog = Dialogic.start("kylie_pistachio", false)
		kylie_pistachio = false
	elif kylie_clues:
		kylie_dialog = Dialogic.start("kylie_clues", false)
		kylie_clues = false
	elif kylie_convo == 5:
		kylie_dialog = Dialogic.start("krita_kylie_4", false)
		$popups/krita_kylie.active = false
	elif kylie_convo == 4:
		kylie_dialog = Dialogic.start("krita_kylie_3", false)
		kylie_convo = 5
		$popups/krita_kylie.active = true
	elif met_phil:
		kylie_dialog = Dialogic.start("krita_kylie_2", false)
		kylie_convo = 3
		$blast/particles0.show()
		$blast/particles1.show()
		$blast/particles2.show()
		$popups/blast.active = true
		$popups/bed.active = false
		$popups/krita_kylie.active = false
	else:
		kylie_dialog = Dialogic.start("krita_kylie_1", false)
		kylie_convo = 2
		$popups/krita_kylie.active = false
		
	kylie_dialog.connect("timeline_end", self, "dialog_end")
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
	if !portal:
		$root_mspm.talking = true
		$popups/bathroom.hide()
		var bathroom_dialog = Dialogic.start("bathroom", false)
		bathroom_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(bathroom_dialog)
	else:
		$root_mspm.position = $popups/bathroom/pos.global_position
		drop_key()
		floor_on = 4
	
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
				$blast/particles0.color = Color(0, 1, 0)
				$blast/particles1.color = Color(0, 1, 0)
				$blast/particles2.color = Color(0, 1, 0)
			"green":
				hole_1 = "blue"
				$blast/particles0.color = Color(0, 0, 1)
				$blast/particles1.color = Color(0, 0, 1)
				$blast/particles2.color = Color(0, 0, 1)
			"blue":
				hole_1 = "red"
				$blast/particles0.color = Color(1, 0, 0)
				$blast/particles1.color = Color(1, 0, 0)
				$blast/particles2.color = Color(1, 0, 0)
				
		set_color()
		
func blast_2_e() -> void:
	match hole_2:
		"red":
			hole_2 = "green"
			$blast_2/particles0.color = Color(0, 1, 0)
			$blast_2/particles1.color = Color(0, 1, 0)
			$blast_2/particles2.color = Color(0, 1, 0)
		"green":
			hole_2 = "blue"
			$blast_2/particles0.color = Color(0, 0, 1)
			$blast_2/particles1.color = Color(0, 0, 1)
			$blast_2/particles2.color = Color(0, 0, 1)
		"blue":
			hole_2 = "red"
			$blast_2/particles0.color = Color(1, 0, 0)
			$blast_2/particles1.color = Color(1, 0, 0)
			$blast_2/particles2.color = Color(1, 0, 0)
		"NULL":
			hole_2 = "red"
			$blast_2/particles0.color = Color(1, 0, 0)
			$blast_2/particles1.color = Color(1, 0, 0)
			$blast_2/particles2.color = Color(1, 0, 0)
			
	set_color()
		
func rotate_puzzle_e() -> void:
	var puzzle = rotate_puzzle.instance()
	puzzle.color = color
	puzzle.apply_color()
	puzzle.apply_data(pistachio_pos, rotate_puzzle_orientation)
	puzzle.connect("exit", self, "puzzle_exit")
	puzzle.connect("solved", self, "puzzle_solved")
	$root_mspm.talking = true
	$canvasLayer.add_child(puzzle)
	
func sketchy_door_e() -> void:
	$root_mspm.position = $popups/sketchy_door/pos.global_position
	floor_on = 1
	
func sketchy_wc_e() -> void:
	$root_mspm.position = $popups/sketchy_wc/pos.global_position
	drop_key()
	floor_on = -1
	
func door_106_e() -> void:
	$root_mspm.position = $popups/door_106/pos.global_position
	
func room_106_e() -> void:
	$root_mspm.position = $popups/room_106/pos.global_position
	
func room_101_e() -> void:
	$root_mspm.position = $popups/room_101/pos.global_position
	
func door_101_e() -> void:
	$root_mspm.position = $popups/door_101/pos.global_position
	
func wc_101_e() -> void:
	if pistachio_portal:
		$root_mspm.position = $popups/wc_101/pos.global_position
		drop_key()
		floor_on = 3
	else:
		$root_mspm.talking = true
		$popups/wc_101.hide()
		var wc_dialog = Dialogic.start("wc_101", false)
		wc_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(wc_dialog)
	
func wc_304_e() -> void:
	$root_mspm.position = $popups/wc_304/pos.global_position
	drop_key()
	floor_on = 1
	
func room_401_e() -> void:
	$root_mspm.position = $popups/room_401/pos.global_position
	
func door_401_e() -> void:
	$root_mspm.position = $popups/door_401/pos.global_position
	
func wc_401_e() -> void:
	$root_mspm.position = $popups/wc_401/pos.global_position
	drop_key()
	floor_on = 2
	
func room_205_e() -> void:
	$root_mspm.position = $popups/room_205/pos.global_position
	
func door_205_e() -> void:
	$root_mspm.position = $popups/door_205/pos.global_position
	
func stairs_200_e() -> void:
	$root_mspm.position = $popups/stairs_200/pos.global_position
	floor_on = 3
	
func stairs_300_0_e() -> void:
	$root_mspm.position = $popups/stairs_300_0/pos.global_position
	floor_on = 2
	
func stairs_300_1_e() -> void:
	$root_mspm.position = $popups/stairs_300_1/pos.global_position
	floor_on = 4
	
func stairs_400_e() -> void:
	$root_mspm.position = $popups/stairs_400/pos.global_position
	floor_on = 3
	
func room_306_e() -> void:
	$root_mspm.position = $popups/room_306/pos.global_position
	
func door_306_e() -> void:
	$root_mspm.position = $popups/door_306/pos.global_position
	
func wc_306_e() -> void:
	$root_mspm.position = $popups/wc_306/pos.global_position
	drop_key()
	floor_on = 1
	
func room_403_e() -> void:
	$root_mspm.position = $popups/room_403/pos.global_position
	
func door_403_e() -> void:
	$root_mspm.position = $popups/door_403/pos.global_position
	
func room_501_e() -> void:
	$root_mspm.position = $popups/room_501/pos.global_position
	$popups/door_501.active = true
	floor_on = 0
	if !portal_2:
		portal_2 = true
		$root_mspm.talking = true
		var portal_dialog = Dialogic.start("portal", false)
		portal_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(portal_dialog)
	
func door_501_e() -> void:
	$root_mspm.position = $popups/door_501/pos.global_position
	floor_on = 5
	
func gareth_e() -> void:
	$root_mspm.talking = true
	$popups/gareth.hide()
	var gareth_dialog
	if gareth_puzzle_solved:
		pass
	elif !gareth_talked:
		gareth_dialog = Dialogic.start("gareth_1", false)
		$popups/krita_kylie.active = true
		$popups/alex.active = true
		$popups/gilbert.active = true
		$popups/natalie.active = true
		$popups/blenders.active = true
		kylie_clues = true
		alex_clues = true
		gilbert_clues = true
		natalie_clues = true
	else:
		gareth_dialog = Dialogic.start("gareth_2", false)
	gareth_dialog.connect("timeline_end", self, "dialog_end")
	gareth_talked = true
	$canvasLayer.add_child(gareth_dialog)
	
func blenders_e() -> void:
	$root_mspm.talking = true
	$popups/blenders.hide()
	var puzzle_dialog = Dialogic.start("shake_puzzle", false)
	puzzle_dialog.connect("timeline_end", self, "dialog_end")
	puzzle_dialog.connect("dialogic_signal", self, "dialogical")
	$canvasLayer.add_child(puzzle_dialog)
	
func alex_e() -> void:
	$root_mspm.talking = true
	$popups/alex.hide()
	var alex_dialog
	if !met_alex:
		alex_dialog = Dialogic.start("alex_1", false)
		met_alex = true
		if !alex_clues and pistachio_bags == 0:
			$popups/alex.active = false
	elif pistachio_bags >= 1 and !portal:
		alex_dialog = Dialogic.start("alex_2", false)
		portal = true
		if !alex_clues:
			$popups/alex.active = false
	elif !pistachio_pile_1:
		alex_dialog = Dialogic.start("alex_3", false)
		if !alex_clues:
			$popups/alex.active = false
	elif alex_clues:
		alex_dialog = Dialogic.start("alex_clues", false)
		alex_clues = false
		$popups/alex.active = false
	alex_dialog.connect("timeline_end", self, "dialog_end")
	alex_dialog.connect("dialogic_signal", self, "dialogical")
	$canvasLayer.add_child(alex_dialog)
	
func gilbert_e() -> void:
	$root_mspm.talking = true
	$popups/gilbert.hide()
	var gilbert_dialog
	if !met_gilbert:
		gilbert_dialog = Dialogic.start("gilbert_1", false)
		met_gilbert = true
		if !gilbert_pistachio and !gilbert_clues:
			$popups/gilbert.active = false
	elif gilbert_pistachio:
		gilbert_dialog = Dialogic.start("gilbert_2", false)
		gilbert_pistachio = false
		pistachio_portal = true
		if !gilbert_clues:
			$popups/gilbert.active = false
	elif gilbert_clues:
		gilbert_dialog = Dialogic.start("gilbert_clues", false)
		gilbert_clues = false
		$popups/gilbert.active = false
	gilbert_dialog.connect("timeline_end", self, "dialog_end")
	$canvasLayer.add_child(gilbert_dialog)
	
func natalie_e() -> void:
	$root_mspm.talking = true
	$popups/natalie.hide()
	var natalie_dialog
	if !met_natalie:
		natalie_dialog = Dialogic.start("natalie_1", false)
		met_natalie = true
		if !natalie_clues:
			$popups/natalie.active = false
	elif !natalie_clues:
		if !alex_clues and !gilbert_clues:
			natalie_dialog = Dialogic.start( \
				"natalie_clues_all", false)
			print("all clues")
		elif !alex_clues:
			natalie_dialog = Dialogic.start( \
				"natalie_clues_alex", false)
			print("alex")
		elif !gilbert_clues:
			natalie_dialog = Dialogic.start( \
				"natalie_clues_gilbert", false)
			print("gilbert")
		else:
			natalie_dialog = Dialogic.start( \
				"natalie_clues_kylie", false)
			print("kylie")
	elif natalie_clues:
		natalie_dialog = Dialogic.start("natalie_clues", false)
		natalie_clues = false
		natalie_clues_all = true
	natalie_dialog.connect("timeline_end", self, "dialog_end")
	$canvasLayer.add_child(natalie_dialog)
	
func kylie_shake_e() -> void:
	$root_mspm.talking = true
	$popups/kylie_shake.hide()
	var kylie_dialog = Dialogic.start("kylie_shake", false)
	kylie_dialog.connect("timeline_end", self, "dialog_end")
	$kylie_shake.hide()
	$kylie_sad.show()
	$popups/kylie_shake.active = false
	$popups/kylie_sad.active = true
	$canvasLayer.add_child(kylie_dialog)
	
func kylie_sad_e() -> void:
	$root_mspm.talking = true
	$popups/kylie_sad.hide()
	var kylie_dialog = Dialogic.start("kylie_sad", false)
	kylie_dialog.connect("timeline_end", self, "dialog_end")
	$popups/kylie_sad.active = false
	$canvasLayer.add_child(kylie_dialog)
	
func room_304_e() -> void:
	if pistachio_pile_1:
		$root_mspm.talking = true
		$popups/room_304.hide()
		var door_dialog
		if !pistachioed:
			door_dialog = Dialogic.start("pistachio_front", false)
			$popups/krita_kylie.active = true
			$popups/gilbert.active = true
			kylie_pistachio = true
			gilbert_pistachio = true
		else:
			door_dialog = Dialogic.start("pistachio_front_2", false)
		pistachioed = true
		door_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(door_dialog)
	else:
		$root_mspm.position = $popups/room_304/pos.global_position
	
func door_304_e() -> void:
	if pistachio_pile_1:
		$root_mspm.talking = true
		$popups/door_304.hide()
		var door_dialog = Dialogic.start("pistachio_back", false)
		door_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(door_dialog)
	else:
		$root_mspm.position = $popups/door_304/pos.global_position
		
func error_e() -> void:
	$root_mspm.talking = true
	$popups/error.hide()
	var door_dialog = Dialogic.start("error", false)
	door_dialog.connect("timeline_end", self, "dialog_end")
	$canvasLayer.add_child(door_dialog)
	
func roof_e() -> void:
	if key:
		$root_mspm.position = $popups/roof/pos.global_position
		floor_on = 6
		$root_mspm.talking = true
		var roof_dialog = Dialogic.start("roof_on", false)
		roof_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(roof_dialog)
	else:
		$root_mspm.talking = true
		$popups/roof.hide()
		$popups/kylie_sad.active = false
		$popups/kylie_shake.active = false
		$popups/krita_kylie.active = true
		$kylie_sad.hide()
		$kylie_shake.hide()
		$krita_kylie.show()
		kylie_convo = 6
		var roof_dialog = Dialogic.start("roof", false)
		roof_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(roof_dialog)
	
func button_left_e() -> void:
	if flip_left:
		flip_left = false
		counterclockwise = true
		target_orientation = $turvy.rotation_degrees - 90
		$arrow_left_0.hide()
		$arrow_left_1.show()
	else:
		flip_left = true
		clockwise = true
		target_orientation = $turvy.rotation_degrees + 90
		$arrow_left_0.show()
		$arrow_left_1.hide()
	
func button_right_e() -> void:
	if flip_right:
		flip_right = false
		counterclockwise = true
		target_orientation = $turvy.rotation_degrees - 90
		$arrow_right_0.hide()
		$arrow_right_1.show()
	else:
		flip_right = true
		clockwise = true
		target_orientation = $turvy.rotation_degrees + 90
		$arrow_right_0.show()
		$arrow_right_1.hide()
		
func ladder_e() -> void:
	var can_go : bool = false
	match color:
		"red":
			if $turvy.rotation_degrees == 0:
				can_go = true
		"green":
			if $turvy.rotation_degrees == 90:
				can_go = true
		"blue":
			if $turvy.rotation_degrees == -90:
				can_go = true
	if !$turvy.has_node("wall"):
		can_go = true
	if can_go:
		$root_mspm.position = $popups/ladder/pos.global_position
		floor_on = 5
	else:
		$root_mspm.talking = true
		$popups/ladder.hide()
		var ladder_dialog = Dialogic.start("ladder", false)
		ladder_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(ladder_dialog)
	
func ladder_down_e() -> void:
	var can_go : bool = false
	match color:
		"red":
			if $turvy.rotation_degrees == 0:
				can_go = true
		"green":
			if $turvy.rotation_degrees == 90:
				can_go = true
		"blue":
			if $turvy.rotation_degrees == -90:
				can_go = true
	if !$turvy.has_node("wall"):
		can_go = true
	if can_go:
		$root_mspm.position = $popups/ladder_down/pos.global_position
		floor_on = 4
	else:
		$root_mspm.talking = true
		$popups/ladder.hide()
		var ladder_dialog = Dialogic.start("ladder", false)
		ladder_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(ladder_dialog)
	
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
		"blast_2":
			$blast_2.show()
			$popups/blast_2.active = true
			$popups/button_left.active = false
			$popups/button_right.active = false
			$yellow_wall.show()
			$yellow_walls/collisionShape.disabled = false
			$turvy.hide()
			delete_children($turvy)
			met_phil_2 = true
			# blast_sfx.play()
			# screen shaek?
		"touch":
			hole_1 = "red"
			$blast/particles0.color = Color(1, 0, 0)
			$blast/particles1.color = Color(1, 0, 0)
			$blast/particles2.color = Color(1, 0, 0)
			set_color()
			kylie_convo = 4
			$popups/krita_kylie.active = true
			# shaek()
			# rumble.play()
		"fade":
			$modLayer/fade.color = Color(0, 0, 0, 0)
			fading = true
		"shake_puzzle":
			var puzzle = shake_puzzle.instance()
			puzzle.connect("exit", self, "shake_puzzle_exit")
			puzzle.connect("submit", self, "shake_puzzle_solved")
			$root_mspm.talking = true
			$canvasLayer.add_child(puzzle)
		"god":
			$modLayer/fade.color = Color(0, 0, 0, 0)
			$root_mspm.position = Vector2(213, 478)
			$popups/gareth.active = false
			$popups/kylie_shake.active = true
			$popups/krita_kylie.active = false
			$graphicsgale_gareth.hide()
			$krita_kylie.hide()
			$kylie_shake.show()
			fading = true
			floor_on = 0
			$root_mspm.talking = true
			var god_dialog = Dialogic.start("god", false)
			god_dialog.connect("timeline_end", self, "dialog_end")
			$canvasLayer.add_child(god_dialog)
			
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
		if $turvy.has_node("wall"):
			$turvy/red_wall/collisionShape.disabled = false
	for child in $green_walls.get_children():
		child.disabled = false
		if $turvy.has_node("wall"):
			$turvy/green_wall/collisionShape.disabled = false
	for child in $blue_walls.get_children():
		child.disabled = false
		if $turvy.has_node("wall"):
			$turvy/blue_wall/collisionShape.disabled = false
	for child in $yellow_walls.get_children():
		child.disabled = false
		if !$yellow_wall.visible:
			child.disabled = true
	for child in $teal_walls.get_children():
		child.disabled = false
	for child in $purple_walls.get_children():
		child.disabled = false
			
	match color:
		"red":
			for child in $red_walls.get_children():
				child.disabled = true
			if $turvy.has_node("wall"):
				$turvy/red_wall/collisionShape.disabled = true
		"green":
			for child in $green_walls.get_children():
				child.disabled = true
			if $turvy.has_node("wall"):
				$turvy/green_wall/collisionShape.disabled = true
		"blue":
			for child in $blue_walls.get_children():
				child.disabled = true
			if $turvy.has_node("wall"):
				$turvy/blue_wall/collisionShape.disabled = true
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
	var array = $canvasLayer.get_child(0).exit()
	pistachio_pos = array[0]
	rotate_puzzle_orientation = array[1]
	$root_mspm.talking = false
	delete_children($canvasLayer)
	
func shake_puzzle_exit() -> void:
	$root_mspm.talking = false
	delete_children($canvasLayer)
	
func puzzle_solved() -> void:
	delete_children($canvasLayer)
	$popups/rotate_puzzle.active = false
	$root_mspm.talking = true
	pistachio_bags += 1
	$popups/alex.active = true
	var puzzle_dialog = Dialogic.start("puzzle_solved", false)
	puzzle_dialog.connect("timeline_end", self, "dialog_end")
	$canvasLayer.add_child(puzzle_dialog)
	
func shake_puzzle_solved(correct : bool) -> void:
	delete_children($canvasLayer)
	$root_mspm.talking = true
	var puzzle_dialog
	if correct:
		$popups/blenders.active = false
		$popups/natalie.active = false
		pistachio_bags += 1
		puzzle_dialog = Dialogic.start("shake_puzzle_solved", false)
	else:
		puzzle_dialog = Dialogic.start("shake_puzzle_failed", false)
	puzzle_dialog.connect("timeline_end", self, "dialog_end")
	puzzle_dialog.connect("dialogic_signal", self, "dialogical")
	$canvasLayer.add_child(puzzle_dialog)
	
func fall() -> void:
	fading = true
	$root_mspm.position = Vector2(-400, -1314)
	floor_on = 3
	if pistachio_pile_1:
		pistachio_pile_1 = false
		$pistachios.hide()
		$pistachios_sad.show()
		$root_mspm.talking = true
		var nut_dialog = Dialogic.start("fallen", false)
		nut_dialog.connect("timeline_end", self, "dialog_end")
		$canvasLayer.add_child(nut_dialog)
		
func drop_key() -> void:
	if $key.visible:
		key = false
		$key/key_pop.active = true
		
func pick_up_key() -> void:
	key = true
	$key/key_pop.hide()
	$key/key_pop.active = false
	
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
	
func _on_trigger_body_entered(body):
	if !met_phil_2:
		$root_mspm.talking = true
		var phil_dialog = Dialogic.start("blast_2", false)
		phil_dialog.connect("timeline_end", self, "dialog_end")
		phil_dialog.connect("dialogic_signal", self, "dialogical")
		$trigger/collisionShape.disabled = true
		$canvasLayer.add_child(phil_dialog)
