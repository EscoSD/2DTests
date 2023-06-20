extends CharacterBody2D

var player: CharacterBody2D = null
var SPEED = 50

@onready var detection_area = $Area2D/CollisionPolygon2D


func _physics_process(delta):
	
	detection_area.rotation += 0.5 * delta
	follow_player(delta)
	move_and_slide()


func body_entered(body):
	player = body


func _on_area_2d_body_exited(_body):
	player = null


func follow_player(delta):
	if player != null:
		velocity = (position.move_toward(player.position, delta) - position).normalized() * SPEED
		rotate_detection_area()
	else:
		velocity = Vector2.ZERO


func rotate_detection_area():
	var rotation_direction = (player.position - position).normalized()
	detection_area.rotation = atan2(rotation_direction.y, rotation_direction.x)

