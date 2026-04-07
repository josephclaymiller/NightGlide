extends Node2D

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	# Connect collected signal of all food in scene
	for food: Node in $Food.get_children():
		if food is Area2D:
			food.collected.connect(_on_food_collected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Quit when escape button is pressed
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_food_collected() -> void:
	score += 1
	print("Score: ", score)
