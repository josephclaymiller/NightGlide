extends Control

const PATH_2D_PLATFORMER: String = "res://2D_Platformer/Scenes/level1.tscn"
#const PATH_3D_PLATFORMER: String = "res://3D_Platformer/Scenes/level1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Show mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# press jump button to start game
	if Input.is_action_just_pressed("jump"):
		start_game()
	# Quit when escape button is pressed
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

#func _on_button_3d_platformer_pressed() -> void:
	#get_tree().change_scene_to_file(PATH_3D_PLATFORMER)

func _on_button_2d_platformer_pressed() -> void:
	start_game()
	
func start_game() -> void:
	print("Start Game")
	get_tree().change_scene_to_file(PATH_2D_PLATFORMER)
