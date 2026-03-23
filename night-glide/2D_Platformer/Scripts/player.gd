extends CharacterBody2D


const SPEED: float = 300.0
const JUMP_VELOCITY: float = -500.0
const GRAVITY_FALL: float = 200.0
const MASK_WORLD: int = 1        # layer 1
const MASK_CLIMBABLE: int = 4    # layer 3 (bit 2 = value 4)

var is_dead: bool = false
var is_gliding: bool = false
var on_tree: bool = false
var is_climbing: bool = false

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	if is_climbing:
		_handle_climb()
	else:
		# Re-enable collision with climbable layer when not climbing
		#set_collision_mask_value(3, true)
		_handle_fall(delta)
	
	_handle_jumps()	
	
	_handle_movement()
	move_and_slide()
	_check_collisions()
	_check_if_dead()
	
func _handle_fall(delta: float) -> void:
	if not is_on_floor():
		if is_gliding:
			_glide(delta)
		else:
			_fall(delta)
	
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
		
func _handle_climb() -> void:
	if Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
	else:
		velocity.y = 0.0
		
func _check_collisions() -> void:
	is_climbing = false
	for i: int in get_slide_collision_count():
		var collision: KinematicCollision2D = get_slide_collision(i)
		var collider: Object = collision.get_collider()
		if collider is CharacterBody2D and collider.is_in_group("enemies"):
			is_dead = true
			return
		if collider.is_in_group("tree"):
			is_climbing = true

func _check_if_dead() -> void:
	if is_dead:
		_end_game()
	# check if fell of world
	if position.y > 680:
		_end_game()

func _end_game() -> void:
	# Tell World to show the game over screen
	self.visible = false
	get_tree().change_scene_to_file("res://2D_Platformer/Scenes/game_over_screen.tscn")
	#get_tree().get_root().get_node("level1/GameOverScreen").visible = true
