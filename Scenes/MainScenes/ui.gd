extends CanvasLayer

func set_tower_preview(tower_type: String, mouse_position: Vector2):
	# load tower scene
	var drag_tower = load("res://Scenes/Towers/" + tower_type + ".tscn").instantiate()
	drag_tower.set_name("DragTower") # make future references easier
	drag_tower.modulate = GameData.error_color # preset the tower as unplaceable
	
	# add range circle to tower preview
	var range_texture = Sprite2D.new()
	var texture = load("res://Assets/UI/range_overlay.png")
	var scaling = GameData.tower_data[tower_type]["range"] / 600.0
	
	# resize range circle to match tower range
	range_texture.position = Vector2(0,0)
	range_texture.scale = Vector2(scaling, scaling)
	range_texture.texture = texture
	range_texture.modulate = GameData.error_color

	# map tower scene onto cursor
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture, true)
	control.position = mouse_position
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child(get_node("TowerPreview"), 0) # Move the tower behind the HUD
	
func update_tower_preview(new_position: Vector2, color: Color) -> void:
	# move the tower to the tile under the cursor and update the build status color
	get_node("TowerPreview").position = new_position
	if get_node("TowerPreview/DragTower").modulate != color:
		get_node("TowerPreview/DragTower").modulate = color
		get_node("TowerPreview/Sprite2D").modulate = color
