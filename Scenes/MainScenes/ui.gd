extends CanvasLayer

@onready var hp_bar = get_node("HUD/InfoBar/H/BaseHealthBar")

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


func _on_pause_play_pressed() -> void:
	# clear tower placement if clicking pause before building
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	
	if get_tree().is_paused():
		get_tree().paused = false
	# Check if game hasn't started yet
	elif get_parent().current_wave == 0:
		get_parent().current_wave += 1
		get_parent().start_next_wave()
	else:
		get_tree().paused = true


func _on_speedup_pressed() -> void:
	# clear tower placement if clicking FF before building
	if get_parent().build_mode:
		get_parent().cancel_build_mode()

	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
		get_node("HUD/GameControls/Speedup").modulate = Color("ffffff")
	else:
		Engine.set_time_scale(2.0)
		get_node("HUD/GameControls/Speedup").modulate = Color("ca904d")

func update_health_bar(base_health:int) -> void:
	var hp_bar_tween = hp_bar.create_tween()
	hp_bar_tween.tween_property(hp_bar, "value", base_health, 0.1)
	if base_health >= 60:
		hp_bar.set_tint_progress("3adb69") # Green
	elif base_health <60 and base_health >= 25:
		hp_bar.set_tint_progress("e1be32") # Orange
	else:
		hp_bar.set_tint_progress("e11e1e") # Red
