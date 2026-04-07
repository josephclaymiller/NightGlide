extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Show mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Quit when escape button is pressed
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

#func _on_button_pressed() -> void:
	##get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://start_screen.tscn")

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://2D_Platformer/Scenes/level1.tscn")
