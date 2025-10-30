extends CharacterBody2D

const SPEED = 80
const GRAVITY = 90
const JUMP_POWER = -1000.0
var n_jumps = 1

func _ready():
	velocity.x = 0
	$AnimatedSprite2D.play("Idle")

# Dos funciones de colisión que referencian los RayCast2D
func nearPlayer():
	var near_node = get_node("/root/Node/EnemyNinjaFrog/Near")  # Ruta explícita a near
	return near_node.is_colliding()

func seePlayer():
	var right_node = get_node("/root/Node/EnemyNinjaFrog/Right")  # Ruta explícita a Right
	return right_node.is_colliding()

# Funciones del movimiento y salto del enemigo
func move():
	velocity.x = SPEED
	$AnimatedSprite2D.play("Run")

func jump():
	if n_jumps > 0:
		velocity.y = JUMP_POWER
		$AnimatedSprite2D.play("Jump")

# Gravedad, movimiento y salto del enemigo
func _physics_process(_delta):
	velocity.y += GRAVITY
	if is_on_floor():
		n_jumps = 1
		if velocity.x > 0:
			$AnimatedSprite2D.play("Run")
		elif velocity.x == 0:
			$AnimatedSprite2D.play("Idle")
	if seePlayer():
		move()
	if nearPlayer():
		jump()
		n_jumps = 0

	move_and_slide()
