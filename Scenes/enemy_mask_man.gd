extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980

func _ready():
	velocity.x = SPEED
	$AnimatedSprite2D.play("Run")

# Dos funciones de colisión que referencian los RayCast2D
func _next_to_left_wall():
	return $Left.is_colliding()

func _next_to_right_wall():
	return $Right.is_colliding()

# Función para dar giro de 180 grados al enemigo
func flip():
	if _next_to_left_wall() or _next_to_right_wall():
		velocity.x *= -1
		$AnimatedSprite2D.scale.x *= -1

# Gravedad y movimiento al enemigo
func _physics_process(delta):
	velocity.y += GRAVITY
	flip()
	move_and_slide()
