# Fox is a ground enemy
# Roams along the ground hunting for player
extends CharacterBody2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -400.0

@onready var sprite: Sprite2D = $Fox

var direction: float = 1.0
var is_turning: bool = false

func _ready() -> void:
	# start fox off going to the left
	direction = -1.0
	
func _physics_process(delta: float) -> void:
	# Fall to ground if not already on ground
	if not is_on_floor():
		velocity += get_gravity() * delta

	_check_turn()
	velocity.x = direction * SPEED
	move_and_slide()

func _check_turn() -> void:
	var hit_wall: bool = is_on_wall()
	
	if hit_wall and not is_turning:
		print("fox hit wall")
		is_turning = true
		direction *= -1.0
		# face fox in direction it's moving
		sprite.scale.x *= -direction
	elif not hit_wall:
		is_turning = false
