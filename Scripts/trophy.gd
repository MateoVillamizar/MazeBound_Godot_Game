extends Area2D

@export var target_level : PackedScene

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		# No podemos cambiar de escena directamente aquí,
		# porque estamos en un callback de física.
		# Usamos 'call_deferred' para que la acción ocurra
		# de forma segura después del paso de física actual.
		call_deferred("_change_scene")

# Función auxiliar que se ejecuta de forma diferida
# Diferir = posponer una acción para que se ejecute en un momento seguro
func _change_scene() -> void:
	get_tree().change_scene_to_packed(target_level) 
