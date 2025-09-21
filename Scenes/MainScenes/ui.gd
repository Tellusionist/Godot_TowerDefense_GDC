extends CanvasLayer

func set_tower_preview(tower_type: String, mouse_position: Vector2):
	# load tower scene
	var drag_tower = load("res://Scenes/Towers/" + tower_type + ".tscn").instantiate()
	drag_tower.set_name("DragTower") # make future references easier
	drag_tower.modulate = Color("ad54ff3c") # preset the tower as unplaceable
	
	# map tower scene onto cursor
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.position = mouse_position
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child(get_node("TowerPreview"), 0) # Move the tower behind the HUD
	
func update_tower_preview(new_position: Vector2, color: Color) -> void:
	# move the tower to the tile under the cursor and update the build status color
	get_node("TowerPreview").position = new_position
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
