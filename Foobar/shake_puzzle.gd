extends Node2D

var answer : bool = false

signal exit
signal submit(correct)

func _ready():
	$numbers_button.grab_focus()
	
func _process(delta):
	get_parent().get_parent().get_node("root_mspm").talking = true
	
	if Input.is_action_just_pressed("exit"):
		emit_signal("exit")
	elif Input.is_action_just_pressed("submit"):
		emit_signal("submit", answer)
		
	answer = false
		
	if $numbers_button/numbers.frame == 7:
		if $ingredient_1_button/ingredient.frame == 0:
			if $ingredient_2_button/ingredient.frame == 3:
				if $ingredient_3_button/ingredient.frame == 4:
					answer = true
			elif $ingredient_2_button/ingredient.frame == 4:
				if $ingredient_3_button/ingredient.frame == 3:
					answer = true
		elif $ingredient_1_button/ingredient.frame == 3:
			if $ingredient_2_button/ingredient.frame == 0:
				if $ingredient_3_button/ingredient.frame == 4:
					answer = true
			elif $ingredient_2_button/ingredient.frame == 4:
				if $ingredient_3_button/ingredient.frame == 0:
					answer = true
		elif $ingredient_1_button/ingredient.frame == 4:
			if $ingredient_2_button/ingredient.frame == 0:
				if $ingredient_3_button/ingredient.frame == 3:
					answer = true
			elif $ingredient_2_button/ingredient.frame == 3:
				if $ingredient_3_button/ingredient.frame == 0:
					answer = true
	
func _on_numbers_button_pressed():
	if $numbers_button/numbers.frame == 9:
		$numbers_button/numbers.frame = 0
	else:
		$numbers_button/numbers.frame += 1
	
func _on_ingredient_1_button_pressed():
	if $ingredient_1_button/ingredient.frame == 4:
		$ingredient_1_button/ingredient.frame = 0
	else:
		$ingredient_1_button/ingredient.frame += 1
	
func _on_ingredient_2_button_pressed():
	if $ingredient_2_button/ingredient.frame == 4:
		$ingredient_2_button/ingredient.frame = 0
	else:
		$ingredient_2_button/ingredient.frame += 1
	
func _on_ingredient_3_button_pressed():
	if $ingredient_3_button/ingredient.frame == 4:
		$ingredient_3_button/ingredient.frame = 0
	else:
		$ingredient_3_button/ingredient.frame += 1
