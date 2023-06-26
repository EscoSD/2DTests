extends CanvasLayer

@export  var d_file:JSON

var dialogue = []
var current_dialogue_id = 0
var d_active = false

func _ready():
	$NinePatchRect.visible = false
#	start()

func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()

func load_dialogue():
	print("Cargando diálogo...")
	
	#Pilla el path del archivo
	var file = "D:/Proyectos_Godot/2DTests/Dialogues/json/chat_prueba.json"
	
	#Obtenemos el contenido
	var json_as_text = FileAccess.get_file_as_string(file)
	
	#Parseamos el contenido
	var json_as_dict = JSON.parse_string(json_as_text)
	
	if json_as_text:
		print(json_as_text)
	else: print("Fallo en json_as_text")
	
	if json_as_dict:
		print(json_as_dict)
		return json_as_dict
	else: print("Fallo en json_as_dict")

func _input(event):
	if not d_active:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()

func next_script():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogue):
		$Timer.start()
		$NinePatchRect.visible = false
		return
	
	$NinePatchRect/Name.text = dialogue[current_dialogue_id].name
	$NinePatchRect/Chat.text = dialogue[current_dialogue_id].text
	


func _on_timer_timeout():
	d_active = false
