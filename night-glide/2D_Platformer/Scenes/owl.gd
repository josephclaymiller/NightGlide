extends CharacterBody2D


const SPEED: float = 300.0
const OWL_HEIGHT: float = 30


@export var tree_group: String = "tree"
@export var player_path: NodePath
@onready var player: CharacterBody2D = get_node(player_path)
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var time_spent_resting: float = 0.0
var target_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if not player.is_on_floor() and not player.is_climbing:
		target_pos = player.global_position
		$AnimatedSprite2D.animation = "fly"
	else:
		var tree_top: Vector2 = _get_nearest_tree_top()
		tree_top.y -= OWL_HEIGHT
		if tree_top != Vector2.ZERO:
			target_pos = tree_top

	var dist: float = global_position.distance_to(target_pos)
	if dist > 4.0:
		var dir: Vector2 = (target_pos - global_position).normalized()
		velocity = dir * SPEED
		if target_pos.x < global_position.x:
			sprite.scale.x = 5.0
			rotation = dir.angle() + PI
		else:
			sprite.scale.x = -5.0
			rotation = Vector2(-dir.x, dir.y).angle() + PI
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
		velocity.y = move_toward(velocity.y, 0.0, SPEED)
		$AnimatedSprite2D.animation = "default"
		rotation = 0.0
	
	move_and_slide()

func _get_nearest_tree_top() -> Vector2:
	var trees: Array = get_tree().get_nodes_in_group(tree_group)
	var nearest_top: Vector2 = Vector2.ZERO
	var nearest_dist: float = INF

	for tree in trees:
		if not tree is StaticBody2D:
			continue
		var shape_owner: int = tree.get_shape_owners()[0]
		var shape: Shape2D = tree.shape_owner_get_shape(shape_owner, 0)
		var offset: Vector2 = tree.shape_owner_get_transform(shape_owner).origin

		var half_height: float = 0.0
		if shape is RectangleShape2D:
			half_height = shape.size.y / 2.0
		elif shape is CapsuleShape2D:
			half_height = shape.height / 2.0

		var top: Vector2 = tree.global_position + offset + Vector2(0.0, -half_height)
		var dist: float = global_position.distance_to(top)

		if dist < nearest_dist:
			nearest_dist = dist
			nearest_top = top

	return nearest_top
