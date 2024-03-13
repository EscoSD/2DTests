extends CharacterBody2D
#esto es un comentario hecho por el makako, Hesco tus muertos

const SPEED = 100.0
var vida = 10

var input_vector:= Vector2.ZERO
var sprint:= 0.0


@onready var animation_tree : AnimationTree = $AnimationTree


func _ready():
	animation_tree.active = true
	animation_tree['parameters/Idle/blend_position'] = Vector2.DOWN
	


func _process(_delta):
	update_animation_parameters()


func _physics_process(_delta):
#	input_vector.x = (Input.get_action_strength("Walk_Right") - Input.get_action_strength("Walk_Left"))
#	input_vector.y = (Input.get_action_strength("Walk_Down") - Input.get_action_strength("Walk_Up"))
	
	input_vector = Input.get_vector("Walk_Left", "Walk_Right", "Walk_Up", "Walk_Down")
	sprint = Input.get_action_strength("Sprint") * 50

	velocity = (
		input_vector.normalized() * (SPEED + sprint)
		if input_vector != Vector2.ZERO 
		else Vector2.ZERO
	)

	move_and_slide()
	
func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animation_tree['parameters/conditions/idle'] = true
		animation_tree['parameters/conditions/is_walking'] = false
		animation_tree['parameters/conditions/is_running'] = false
	
	elif sprint > 0:
		animation_tree['parameters/conditions/idle'] = false
		animation_tree['parameters/conditions/is_walking'] = false
		animation_tree['parameters/conditions/is_running'] = true
	
	else:
		animation_tree['parameters/conditions/idle'] = false
		animation_tree['parameters/conditions/is_walking'] = true
		animation_tree['parameters/conditions/is_running'] = false
	
	if (input_vector != Vector2.ZERO):
		animation_tree['parameters/Idle/blend_position'] = input_vector
		animation_tree['parameters/Walk/blend_position'] = input_vector
		animation_tree['parameters/Run/blend_position'] = input_vector



func _on_hurt_box_body_entered(body:Enemy):
	body.cambiaPermiso()
	vida -= 1;
	if vida <= 0:
		print("Has muerto")
		mueres()
		

func mueres():
	var padre = get_parent()
	padre.finJuego()

