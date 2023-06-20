extends CharacterBody2D


const SPEED = 100.0

var direction: Vector2
var dir_anim = Vector2(0, 0)
var moving_y: bool
var moving_x: bool

var array : Array[Vector2] = []


func _physics_process(delta):
	move_player()
	move_and_slide()


func move_player():
	
	moving_y = false
	moving_x = false

#Justo cuando sueltas
	if Input.is_action_just_released('ui_down'):
		remove_dir_anim(1)
	if Input.is_action_just_released('ui_up'):
		remove_dir_anim(-1)
	if Input.is_action_just_released('ui_right'):
		remove_dir_anim(2)
	if Input.is_action_just_released('ui_left'):
		remove_dir_anim(-2)
		
#Mientras mantienes presionado
	if Input.is_action_pressed('ui_down') and not Input.is_action_pressed('ui_up'):
		add_dir_anim(1)
		velocity.y = SPEED
		direction = Vector2.DOWN if direction == Vector2.ZERO else direction
		moving_y = true
	
	if Input.is_action_pressed('ui_up') and not Input.is_action_pressed('ui_down'):
		add_dir_anim(-1)
		velocity.y = -SPEED
		direction = Vector2.UP if direction == Vector2.ZERO else direction
		moving_y = true
	
	if Input.is_action_pressed('ui_right') and not Input.is_action_pressed('ui_left'):
		add_dir_anim(2)
		velocity.x = SPEED
		direction = Vector2.RIGHT if direction == Vector2.ZERO else direction
		moving_x = true
	
	if Input.is_action_pressed('ui_left') and not Input.is_action_pressed('ui_right'):
		add_dir_anim(-2)
		velocity.x = -SPEED
		direction = Vector2.LEFT if direction == Vector2.ZERO else direction
		moving_x = true
	
	if not moving_x:
		velocity.x = lerp(velocity.x, 0.0, 0.4)
		
	if not moving_y:
		velocity.y = lerp(velocity.y, 0.0, 0.4)
	
	if not moving_x and not moving_y:
		play_idle_anim()
		direction = Vector2.ZERO
	else:
		play_walk_anim()
		velocity = velocity.normalized() * SPEED


func play_walk_anim():
	if dir_anim[0] == 2: # RIGHT
		$AnimationPlayer.play("Right_Walk")

	elif dir_anim[0] == -2: # LEFT
		$AnimationPlayer.play("Left_Walk")

	elif dir_anim[0] == 1: # DOWN
		$AnimationPlayer.play("Down_Walk")

	elif dir_anim[0] == -1: # UP
		$AnimationPlayer.play("Up_Walk")


func play_idle_anim():
	if direction == Vector2(1, 0): # RIGHT
		$AnimationPlayer.play("Idle")
		print('Idle_Right')
		
	elif direction == Vector2(-1, 0): # LEFT
		$AnimationPlayer.play("Idle")
		print('Idle_Left')
		
	elif direction == Vector2(0, 1): # DOWN
		$AnimationPlayer.play("Idle")
		print('Idle_Down')
		
	elif direction == Vector2(0, -1): # UP
		$AnimationPlayer.play("Idle")
		print('Idle_Up')

#Añade la siguiente orientación de la animación
func add_dir_anim(n):
	if dir_anim[0] != n and dir_anim[1] != n:
		if dir_anim[0] == 0:
			dir_anim[0] = n
		else:
			dir_anim[1] = n

#Quita la siguiente orientación de la animación
func remove_dir_anim(n):
	if dir_anim[0] == n:
		dir_anim[0] = dir_anim[1]
		dir_anim[1] = 0
		
	elif dir_anim[1] == n:
		dir_anim[1] = 0
