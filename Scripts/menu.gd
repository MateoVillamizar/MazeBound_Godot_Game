extends Node

var ui_node

# Oculta el árbol al comenzar
func _ready():
	ui_node = get_node("/root/Ui")
	ui_node.hide()

# Muestra el árbol al terminar
func _exit_tree():
	ui_node.show()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/nivel1.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/nivel2.tscn")
