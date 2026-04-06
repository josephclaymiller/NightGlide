extends CharacterBody2D


const SPEED: float = 300.0
const ROTATION_SPEED: float = 1.0
const TOP_ROTATION: float = 70.0
const BOTTOM_ROTATION: float = -70.0
const MIN_WAIT_TIME: float = 5.0
const MAX_WAIT_TIME: float = 20.0

var rotating_clockwise: bool = true
var waiting: bool = true
var wait_timer: float = 0.0
var starting_rotation: float = 70.0
@export var facing_right: bool = false
var dir: float = 1

func _ready() -> void:
	if facing_right:
		dir = -1
	rotation_degrees = starting_rotation * dir
	wait_timer = randf_range(MIN_WAIT_TIME, MAX_WAIT_TIME)
	
func _physics_process(delta: float) -> void:
	if waiting:
		wait_timer -= delta
		if wait_timer <= 0.0:
			waiting = false
			rotating_clockwise = facing_right
	elif rotating_clockwise:
		rotate(ROTATION_SPEED * delta)
		if rotation_degrees >= TOP_ROTATION:
			rotating_clockwise = false
			if not facing_right:
				waiting = true
				wait_timer = randf_range(MIN_WAIT_TIME, MAX_WAIT_TIME)
	else:
		rotate(-ROTATION_SPEED * delta)
		if rotation_degrees <= BOTTOM_ROTATION:
			rotating_clockwise = true
			if facing_right:
				waiting = true
				wait_timer = randf_range(MIN_WAIT_TIME, MAX_WAIT_TIME)

	move_and_slide()
