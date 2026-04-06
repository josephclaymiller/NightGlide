extends Control

const PATH_2D_PLATFORMER: String = "res://2D_Platformer/Scenes/level1.tscn"
const PATH_3D_PLATFORMER: String = "res://3D_Platformer/Scenes/level1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_3d_platformer_pressed() -> void:
	get_tree().change_scene_to_file(PATH_3D_PLATFORMER)


func _on_button_2d_platformer_pressed() -> void:
	get_tree().change_scene_to_file(PATH_2D_PLATFORMER)
