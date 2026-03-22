# Fox is a ground enemy
# Roams along the ground hunting for player
extends CharacterBody2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -400.0

# As long as the world has edges to fall off, 
# use ray casting to check for ledge and turn fox around
@onready var ledge_ray: RayCast2D = $RayCast2D

var direction: float = 1.0
var is_turning: bool = false

func _ready() -> void:
	assert(ledge_ray != null, "ledge_ray is null — check node name and path")
	# Ensure ray starts on the correct side for the initial direction
	ledge_ray.position.x = abs(ledge_ray.position.x) * direction

func _physics_process(delta: float) -> void:
	# Fall to ground if not already on ground
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Mirror ray BEFORE the check so it's always scanning the correct side
	ledge_ray.position.x = abs(ledge_ray.position.x) * direction

	_check_turn()
	velocity.x = direction * SPEED
	move_and_slide()


func _check_turn() -> void:
	var hit_wall: bool = is_on_wall()
	var at_ledge: bool = is_on_floor() and not ledge_ray.is_colliding()

	if (hit_wall or at_ledge) and not is_turning:
		is_turning = true
		direction *= -1.0
	elif not hit_wall and ledge_ray.is_colliding():
		is_turning = false
