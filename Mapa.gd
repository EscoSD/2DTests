extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var level_navigation_map = get_world_2d().get_navigation_map()
	NavigationServer2D.map_set_edge_connection_margin(level_navigation_map, 1000.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
