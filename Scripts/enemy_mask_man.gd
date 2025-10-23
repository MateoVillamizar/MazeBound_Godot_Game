extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980

func _ready():
	velocity.x = SPEED
	$AnimatedSprite2D.play("Run")

# Dos funciones de colisión que referencian los RayCast2D
func _next_to_left_wall():
	var left_node = get_node("/root/Node/EnemyMaskMan/Left")  # Ruta explícita a Left
	if left_node:
		return left_node.is_colliding()
	return false

func _next_to_right_wall():
	var right_node = get_node("/root/Node/EnemyMaskMan/Right")   # Ruta explícita a Right
	if right_node:
		return right_node.is_colliding()
	return false

# Función para dar giro de 180 grados al enemigo
func flip():
	if _next_to_left_wall() or _next_to_right_wall():
		velocity.x *= -1
		$AnimatedSprite2D.scale.x *= -1

# Gravedad y movimiento al enemigo
func _physics_process(_delta):
	velocity.y += GRAVITY
	flip()
	move_and_slide()
