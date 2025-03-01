extends CharacterBody2D


var speed = 70
var player_state


func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	
	# snap position to whole pixels to prevent pixel splitting
	position.x = round(position.x)
	position.y = round(position.y)
	
	play_animation(direction)
	

func play_animation(direction):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "walking":
		# 4-way movement
		if direction.y == -1:
			$AnimatedSprite2D.play("walk_back")
		if direction.y == 1:
			$AnimatedSprite2D.play("walk_front")
		if direction.x == -1:
			$AnimatedSprite2D.play("walk_left")
		if direction.x == 1:
			$AnimatedSprite2D.play("walk_right")
	
		# diagonal movement
		if direction.x > 0.5 and direction.y < -0.5:
			$AnimatedSprite2D.play("walk_right")
		if direction.x > 0.5 and direction.y > 0.5:
			$AnimatedSprite2D.play("walk_right")
		if direction.x < -0.5 and direction.y > 0.5:
			$AnimatedSprite2D.play("walk_left")
		if direction.x < -0.5 and direction.y < -0.5:
			$AnimatedSprite2D.play("walk_left")


func player():
	pass
