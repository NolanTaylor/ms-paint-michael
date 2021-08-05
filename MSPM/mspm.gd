extends KinematicBody2D

const SPEED = 200

var talking : bool = false
var anim : String = "NULL"
var velocity : Vector2

signal interact

func _ready():
	pass
	
func _physics_process(delta):
	if anim != "NULL":
		$michael.play(anim)
		
	move_and_collide(velocity * delta)
		
	if !talking:
		if Input.is_action_pressed("left"):
			velocity.x = -SPEED
			if Input.is_action_pressed("run"):
				velocity.x = -SPEED * 2
			anim = "walk"
			$michael.flip_h = true
		elif Input.is_action_pressed("right"):
			velocity.x = SPEED
			if Input.is_action_pressed("run"):
				velocity.x = SPEED * 2
			anim = "walk"
			$michael.flip_h = false
		else:
			anim = "idle"
			velocity.x = lerp(velocity.x, 0, 0.25)
			
		if Input.is_action_just_pressed("interact"):
			emit_signal("interact")
	else:
		velocity.x = lerp(velocity.x, 0, 0.25)
		anim = "idle"
