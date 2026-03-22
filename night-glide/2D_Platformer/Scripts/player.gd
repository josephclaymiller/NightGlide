extends CharacterBody2D


const SPEED: float = 300.0
const JUMP_VELOCITY: float = -500.0
const GRAVITY_FALL: float = 200.0

var is_dead: bool = false
var is_gliding: bool = false

func _physics_process(delta: float) -> void:
	if is_dead:
		return
		
	# Glide while not on ground
	if not is_on_floor():
		if is_gliding:
			_glide(delta)
		else:
			_fall(delta)
			
	# Check if jump key pressed an handle jump
	_handle_jumps()
	
	# Check if left/right key pressed and handle movement
	_handle_movement()
	
	# Check if dead and end game
	_check_enemy_collision()
	
	# Move player according to left/right movement and jump/glide/fall
	move_and_slide()
	
func _handle_jumps() -> void:
	# Check if jump key pressed
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			_jump()
	
	# Check if jump key held down
	if Input.is_action_pressed("ui_accept"):
		if velocity.y > 0.0:
			is_gliding = true

	# Check if jump key released
	if Input.is_action_just_released("ui_accept"):
		is_gliding = false
	
func _glide(delta: float) -> void:
	velocity.y += GRAVITY_FALL * delta
	
func _fall(delta: float) -> void:
	velocity += get_gravity() * delta

func _jump() -> void:
	velocity.y = JUMP_VELOCITY

func _handle_movement() -> void:
	# TODO: replace UI actions with custom gameplay actions.
	var direction: float = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
		
func _check_enemy_collision() -> void:
	for i: int in get_slide_collision_count():
		var collision: KinematicCollision2D = get_slide_collision(i)
		var collider: Object = collision.get_collider()
		if collider is CharacterBody2D and collider.is_in_group("enemies"):
			_die()
			return

func _die() -> void:
	is_dead = true
	# Tell World to show the game over screen
	get_tree().get_root().get_node("World_2D_Platformer/GameOverScreen").visible = true
