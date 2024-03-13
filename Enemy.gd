class_name Enemy
extends CharacterBody2D

var player: CharacterBody2D = null
var SPEED = 50
var vida = 10
var permiso = true


@onready var ORIGIN = position


@onready var detection_area = $Area2D/CollisionPolygon2D
@onready var area = $Area2D/Polygon2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D




func _physics_process(delta):
	
	detection_area.rotation += 0.5 * delta
	area.rotation += 0.5 * delta
	if permiso:
		follow_player(delta)
	else:
		uir(delta)
		
	fin_persecucion()
	
	if player == null and sqrt(pow(ORIGIN.x - position.x, 2)+pow(ORIGIN.y - position.y, 2)) >= 5:
		regresa(delta)
		
	

func cambiaPermiso():
	if permiso:
		permiso = false
	else:
		permiso = true

func body_entered(body):
	player = body


func fin_persecucion():
	if player != null:
		var dis = sqrt(pow(player.position.x - position.x, 2)+pow(player.position.y - position.y, 2))
#		print("Distancaia al jugador de " , dis)
		if dis > 200.0 or dis < -200.0:
			player = null



func follow_player(delta):
	if player != null:
		make_path()
		var distancia = position.distance_to(player.position)
		velocity = (position.move_toward(player.position, delta) - position).normalized() * SPEED
		rotate_detection_area()
		
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * SPEED
		move_and_slide()
		#if distancia < 18 :
			#position = position - dir*10
			#player.position = player.position + dir*10
		
	else:
		velocity = Vector2.ZERO
		
func uir(delta):
	
	if player != null:
		make_path()
		var distancia = position.distance_to(player.position)
		if distancia < 50:
			velocity = (position.move_toward(player.position, delta) - position).normalized() * SPEED
			rotate_detection_area()
			
			var dir = to_local(nav_agent.get_next_path_position()).normalized()
			velocity = -dir * SPEED*3
			move_and_slide()
		else:
			cambiaPermiso()
			follow_player(delta)

		
	else:
		velocity = Vector2.ZERO


func rotate_detection_area():
	var rotation_direction = (player.position - position).normalized()
	detection_area.rotation = atan2(rotation_direction.y, rotation_direction.x)
	area.rotation = atan2(rotation_direction.y, rotation_direction.x)


func make_path() ->void:
	nav_agent.target_position = player.global_position
	

func regresa(delta):
	print("PATO")
	velocity = (position.move_toward(ORIGIN, delta) - position).normalized() * SPEED
	move_and_slide()
	

