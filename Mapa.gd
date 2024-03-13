extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var level_navigation_map = get_world_2d().get_navigation_map()
	NavigationServer2D.map_set_edge_connection_margin(level_navigation_map, 1000.0)
	$GameOver/ColorRect.visible = false
	$pausa/ColorRect.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func finJuego():
	$GameOver/ColorRect.visible = true
	get_tree().paused = true
	
func pausarJuego():
	$pausa/ColorRect.visible = true
	get_tree().paused = true

func _on_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _input(event):
	if event.is_action_pressed('ui_cancel'):
		pausarJuego()


func _on_volver_pressed():
	get_tree().paused = false
	$pausa/ColorRect.visible = false
