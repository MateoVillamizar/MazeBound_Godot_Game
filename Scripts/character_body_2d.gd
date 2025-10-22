extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const FRICTION = 100
var jump_label
@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var cam = $Camera2D # Reference to the camera

@onready var cam_timer: Timer = $CamTimer # Reference to CamTimer

# Reference to the Timer (used for coyote time)
@onready var timer = $Timer # keeps a small extra time margin

func _ready():
	jump_label = get_node("/root/Ui/Sprite2D/JumpLabel")

# variables
var accum = 0  # Acumulador que se usa para mover la cámara en el eje X
var itera = 0  # Contador de "iteraciones" (cuántas veces se ha movido hacia la derecha)
var conta = 0  # Contador usado al devolver la cámara hacia la izquierda
var maxim = 50 # Límite de iteraciones antes de empezar el retorno
var steps = 40 # Cantidad de píxeles que se mueve la cámara en cada paso

# Invoke the Timer and disabled the "drag" in the camera
func CameraMove():
	itera = 0
	conta = 0
	accum = 0
	cam_timer.start()
	cam.drag_horizontal_enabled = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Add the run and idle animation
	if (velocity.x > 1 || velocity.x < -1):
		player_sprite.animation = "Run"
	else:
		player_sprite.animation = "Idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		player_sprite.animation = "Jump"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or timer.time_left > 0.0):
		velocity.y = JUMP_VELOCITY
		jump_label.text = str(int(jump_label.text) - 1) # Se actualiza el jump label con los saltos disponibles
		$JumpSound.play() # Audio feedback 

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)

	# Flip the character
	if velocity.x != 0:
		player_sprite.flip_h = velocity.x < 0 
	
	# Zoom in pressing R (0.5)
	if Input.is_action_just_pressed("ZoomIn"):
		if(cam.zoom <= Vector2(2,2)): # limite condición para el zoomIn
			cam.zoom = cam.zoom + Vector2(.5,.5)
		
	# Zoom out pressing T (0.5)
	if Input.is_action_just_pressed("ZoomOut"):
		if(cam.zoom > Vector2(.5,.5)): # limite condición para el zoomOut
			cam.zoom = cam.zoom - Vector2(.5,.5)
		
	# CamerMove pressing J
	if Input.is_action_just_pressed("Recorrido"):
		CameraMove()

	# Store previous floor state
	var was_on_floor = is_on_floor()
	move_and_slide()
	
	# Detect if player just left a ledge (start coyote time)
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		timer.start()

func _on_cam_timer_timeout():
	# Fase 1: mover hacia la derecha
	if (itera <= maxim):
		accum += steps
		cam.position = Vector2(accum, 0)
		itera += 1
	
	# Fase 2: regresar hacia la izquierda
	if (itera > maxim):
		if (cam.position > Vector2(0,0)):
			accum -= steps
			cam.position = Vector2(accum, 0)
			conta += 1
			
			# Cuando ya regresó al inicio
			if (conta == maxim):
				cam_timer.stop()
				cam.drag_horizontal_enabled = true # Camara vuelve a seguir al jugador
