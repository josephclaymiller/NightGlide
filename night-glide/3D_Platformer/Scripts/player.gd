extends CharacterBody3D


const SPEED = 5.0
const ROTATION_SPEED: float = 3.0
const JUMP_VELOCITY = 4.5


var is_climbing: bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if is_climbing:
		_handle_climb()
	
	_handle_movement(delta)
		
	_check_collisions()

	move_and_slide()

func _handle_climb() -> void:
	if Input.is_action_pressed("ui_up"):
		velocity.y = SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.y = -SPEED
	else:
		velocity.y = 0.0

func _handle_movement(delta: float) -> void:
		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Rotate left/right
	rotation.y -= input_dir.x * ROTATION_SPEED * delta
	
	if direction:
		velocity.x = -direction.x * SPEED
		velocity.z = -direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
func _check_collisions() -> void:
	is_climbing = false
	for i: int in get_slide_collision_count():
		var collision: KinematicCollision3D = get_slide_collision(i)
		var collider: Object = collision.get_collider()
		if collider.is_in_group("tree"):
			is_climbing = true
