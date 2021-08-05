extends Node2D

const SPEED = 40

var target_orientation : int = 0
var moving : String = "NULL"
var color : String = "NULL"

signal exit
signal solved

func apply_color() -> void:
	if color == "red":
		for child in $puzzle/red_walls.get_children():
			child.disabled = true
	elif color == "green":
		for child in $puzzle/green_walls.get_children():
			child.disabled = true
			
func apply_data(bag_pos, orientation) -> void:
	$fixed_point/pistachio_bag.position = bag_pos
	$fixed_point.rotation_degrees = orientation
	$puzzle.rotation_degrees = orientation
			
func exit() -> Array:
	return [
		$fixed_point/pistachio_bag.position,
		$puzzle.rotation_degrees
		]
	
func _ready():
	pass
	
func _process(delta):
	if $puzzle/finish.overlaps_body($fixed_point/pistachio_bag):
		emit_signal("solved")
	
	if moving == "NULL":
		$fixed_point/pistachio_bag.move_and_slide( \
			Vector2(0, 128), Vector2(0, -1))
	else:
		$fixed_point/pistachio_bag.move_and_collide(Vector2(0, 0))
	
	if moving == "cw":
		$puzzle.rotation_degrees += SPEED * delta
		$fixed_point.rotation_degrees += SPEED * delta
		
		if $puzzle.rotation_degrees >= target_orientation:
			$puzzle.rotation_degrees = target_orientation
			$fixed_point.rotation_degrees = target_orientation
			while int($puzzle.rotation_degrees) % 90 != 0:
				$puzzle.rotation_degrees -= 1
			target_orientation = 0
			moving = "NULL"
	elif moving == "ccw":
		$puzzle.rotation_degrees -= SPEED * delta
		$fixed_point.rotation_degrees -= SPEED * delta
		
		if $puzzle.rotation_degrees <= target_orientation:
			$puzzle.rotation_degrees = target_orientation
			$fixed_point.rotation_degrees = target_orientation
			while int($puzzle.rotation_degrees) % 90 != 0:
				$puzzle.rotation_degrees -= 1
			target_orientation = 0
			moving = "NULL"
	
	if moving == "NULL" and $fixed_point/pistachio_bag.is_on_floor():
		if Input.is_action_just_pressed("exit"):
			emit_signal("exit")
		elif Input.is_action_just_pressed("restart"):
			target_orientation = 0
			moving = "NULL"
			$puzzle.rotation_degrees = 0
			$fixed_point/pistachio_bag.position = Vector2(-178, -192)
		elif Input.is_action_just_pressed("left"):
			moving = "ccw"
			while int($puzzle.rotation_degrees) % 90 != 0:
				$puzzle.rotation_degrees -= 1
			target_orientation = $puzzle.rotation_degrees - 90
			if $puzzle.rotation_degrees == -360:
				$puzzle.rotation_degrees = 0
				target_orientation = -90
		elif Input.is_action_just_pressed("right"):
			moving = "cw"
			while int($puzzle.rotation_degrees) % 90 != 0:
				$puzzle.rotation_degrees -= 1
			target_orientation = $puzzle.rotation_degrees + 90
			if $puzzle.rotation_degrees == 360:
				$puzzle.rotation_degrees = 0
				target_orientation = 90
