extends Node2D

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect collected signal of all food in scene
	for food: Node in $Food.get_children():
		if food is Area2D:
			food.collected.connect(_on_food_collected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_food_collected() -> void:
	score += 1
	print("Score: ", score)
