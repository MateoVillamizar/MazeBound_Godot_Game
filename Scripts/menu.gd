extends Node

var ui_node
var music_node  # Referencia al reproductor de música

# Oculta el nod UI al comenzar
func _ready():
	ui_node = get_node("/root/Ui")
	ui_node.hide()
	
	# Obtener la referencia al AudioStreamPlayer que está reproduciendo la música
	music_node = get_node("/root/Ui/GameAudio")  # Ajusta la ruta a tu nodo de música
	music_node.stop()  # Detener la música
	
	SingleGameManager.reset_stats()

# Muestra el árbol al terminar
func _exit_tree():
	ui_node.show()
	
	# Reproducir música
	music_node.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/nivel1.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/nivel2.tscn")
