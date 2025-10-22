extends Node

var points_label
var jump_label
var texture_progress_bar
var puntos = 0

func _ready():
	points_label = get_node("/root/Ui/Panel/PointsLabel")
	jump_label = get_node("/root/Ui/Sprite2D/JumpLabel")
	texture_progress_bar = get_node("/root/Ui/TextureRect/TextureProgressBar")

func add_puntos():
	puntos += 1
	points_label.text = str(puntos)
	texture_progress_bar.value += 1 # Incrementar barra de progreso

# Reinicia el contador de coleccionables y de saltos en la UI 
func reset_stats():
	puntos = 0
	points_label.text = str(puntos)
	texture_progress_bar.value = 0
	jump_label.text = str(80)
