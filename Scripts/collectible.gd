extends Area2D

var coin_sound
var spawner

func _ready():
	coin_sound = get_node("/root/Ui/CoinSound")
	spawner = get_node("/root/Node/Spawner")

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		SingleGameManager.add_puntos()
		coin_sound.playing = true # Reproducimos el sonido de la moneda
		queue_free() # eliminarlo
		
		# Notificar al Spawner que el coleccionable fue consumido si la moneda fue generada por el spawner
		if spawner and self.has_meta("spawned_by_spawner") and self.get_meta("spawned_by_spawner"):
			spawner.on_collectible_consumed()  # Notificar al Spawner que el coleccionable fue consumido
