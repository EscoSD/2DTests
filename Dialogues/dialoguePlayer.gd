extends CanvasLayer

@export  var d_file : JSON
@export  var textSpeed = 0.05

var dialogue = []
var current_dialogue_id = 0
var d_active = false

var finished = false

func _ready():
	$NinePatchRect.visible = false
#	start()

func start():
	print("Activo?: ", d_active)
	$Timer.wait_time = textSpeed
	
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()
	print("Activo Final?: ", d_active)

func load_dialogue():
	print("Cargando diálogo...")
	
	#Pilla el path del archivo
	var file = "D:/Proyectos_Godot/2DTests/Dialogues/json/chat_prueba.json"
	
	#Obtenemos el contenido
	var json_as_text = FileAccess.get_file_as_string(file)
	
	#Parseamos el contenido
	var json_as_dict = JSON.parse_string(json_as_text)
	
	if json_as_text:
#		print(json_as_text)
		pass
	else: print("Fallo en json_as_text")
	
	if json_as_dict:
#		print(json_as_dict)
		return json_as_dict
	else: print("Fallo en json_as_dict")

func _input(event):
	if not d_active:
#		print("No está activo")
		return
#	print("Si está activo")
	if event.is_action_pressed("ui_accept"):
		if finished:
			#print("Si he acabado")
			next_script()
		else:
			#print("No he acabado")
			$NinePatchRect/Chat.visible_characters = len($NinePatchRect/Chat.text)

func next_script():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogue):

		$Timer.start()
		await $Timer.timeout
		close_dialogue()
		$NinePatchRect.visible = false
		return
	
	$NinePatchRect/Name.text = dialogue[current_dialogue_id].name
	$NinePatchRect/Chat.text = dialogue[current_dialogue_id].text
	
	$NinePatchRect/Chat.visible_characters = 0
	
	while $NinePatchRect/Chat.visible_characters < len($NinePatchRect/Chat.text):
		#print("Visible characters: ", $NinePatchRect/Chat.visible_characters)
		$NinePatchRect/Chat.visible_characters += 1
		
		$Timer.start()
		await $Timer.timeout
	
	finished = true
	return

func close_dialogue():
	d_active = false
