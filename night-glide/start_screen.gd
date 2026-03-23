extends Control

const PATH_2D_PLATFORMER: String = "res://2D_Platformer/Scenes/world_2D_platformer.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(PATH_2D_PLATFORMER)
