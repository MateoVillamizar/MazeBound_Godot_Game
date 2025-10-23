extends Area2D

var coin_sound

func _ready():
	coin_sound = get_node("/root/Ui/CoinSound")

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		SingleGameManager.add_puntos()
		coin_sound.playing = true
		queue_free() # eliminarlo
