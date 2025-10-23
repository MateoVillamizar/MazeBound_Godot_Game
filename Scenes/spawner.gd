extends Node2D

@onready var coin = load("res://Scenes/collectible_coin.tscn")
var timer
var spawner_count = 0
# Flag para controlar si el coleccionable fue consumido
var consumed_collectible: bool = false

func _ready():
	timer = get_node("Timer")
	timer.stop()  # Asegurarnos de que el temporizador esté detenido al inicio
	timer.wait_time = randf_range(3,5) # Tiempo aleatorio para el siguiente spawn
	spawn()  # Generar el primer coleccionable inmediatamente
	timer.start()  # Iniciar el temporizador
	
func spawn():
	var inst = coin.instantiate()
	add_child(inst)
	consumed_collectible = false  # El coleccionable no ha sido consumido aún
	# Marcamos la moneda como generada por el spawner
	inst.set_meta("spawned_by_spawner", true)
	spawner_count += 1 # Sumamos 1 al spawner_count


# Función que se llama cuando el Timer se detiene
func _on_timer_timeout():
	# Se genera un nuevo coleccionable si el anterior fue consumido y no se han generado más de 4 monedas
	if consumed_collectible and spawner_count < 4:
		spawn()  # Genera un nuevo coleccionable
		timer.stop()
		timer.wait_time = randf_range(3, 5)  # Tiempo aleatorio para el siguiente spawn
		timer.start() # Reiniciamos el temporizador para la próxima generación

# Se llama a esta función cuando el jugador recoja el coleccionable
func on_collectible_consumed():
	consumed_collectible = true  # El coleccionable ha sido consumido
	timer.stop()
	timer.wait_time = randf_range(3, 5)  # Establece un nuevo tiempo aleatorio
	timer.start()  # Reinicia el temporizador para generar el siguiente coleccionable
