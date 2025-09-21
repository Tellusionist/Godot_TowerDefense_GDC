extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_location
var build_type

func _ready() -> void:
	map_node = get_node("Map1") ## We'll convert to variable based on selected map
	
	# hook up all build buttons to the build mode function
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(func(): initiate_build_mode(i.get_name()))
	
func _process(delta) -> void:
	# check if tower is placeable (when in build mode) and update color
	if build_mode:
		update_tower_preview()
	
func _unhandled_input(event: InputEvent) -> void:
	# check if user is indicated to build or cancel tower placement
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
	
func initiate_build_mode(tower_type: String) -> void:
	# don't allow initiating build mode if already in build mode
	if build_mode:
		return
	# see what button was clicked then preview building / placing a tower
	build_type = tower_type + "_t1"
	build_mode = true
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_local(current_tile)
	
	# check if the current tile is occupied by something on the TowerExclusion layer
	# -1 means no tile, is present 
	if map_node.get_node("TowerExclusion").get_cell_source_id(current_tile) == -1: 
		get_node("UI").update_tower_preview(tile_position, "adff4545")
		build_valid = true
		build_location = tile_position
	else:
		get_node("UI").update_tower_preview(tile_position,  "ad54ff3c")
		build_valid = false
	
	
func cancel_build_mode():
	# reset build opens and clear tower preview scene
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").queue_free()

func verify_and_build():
	## place tower on map assuming all conditions are met
	if build_valid:
		## check if the player has enough cash to purchase tower
		var new_tower = load("res://Scenes/Towers/" + build_type + ".tscn").instantiate()
		new_tower.position = build_location
		map_node.get_node("Towers").add_child(new_tower, true)
		## deduct cash
		## update cash label
