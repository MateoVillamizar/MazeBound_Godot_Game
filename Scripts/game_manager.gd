extends Node2D
@onready var points_label: Label = %PointsLabel
@onready var texture_progress_bar: TextureProgressBar = %TextureProgressBar

var puntos = 0

func add_puntos():
	puntos += 1
	points_label.text = str(puntos)
	texture_progress_bar.value += 1 # Incrementar barra de progreso
