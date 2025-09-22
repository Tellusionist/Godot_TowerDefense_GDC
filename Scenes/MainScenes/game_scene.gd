extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_tile # tilemap coordinates
var build_location # local coordinates
var build_type 
var transparent_tile = 7 # tile index for transparent tile to mark tower placement
var transparent_tile_id = Vector2i(1,0) # tile id for transparent tile to mark tower placement

var current_wave = 0
var enemimies_in_wave = 0

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

##
## BUILDING FUNCTIONS
##

func initiate_build_mode(tower_type: String) -> void:
	# don't allow initiating build mode if already in build mode
	if build_mode:
		cancel_build_mode()
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
		get_node("UI").update_tower_preview(tile_position, GameData.valid_color)
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		get_node("UI").update_tower_preview(tile_position, GameData.error_color)
		build_valid = false
	
func cancel_build_mode():
	# reset build opens and clear tower preview scene
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").free() # need to clear in same frame

func verify_and_build():
	## place tower on map assuming all conditions are met
	if build_valid:
		## check if the player has enough cash to purchase tower
		var new_tower = load("res://Scenes/Towers/" + build_type + ".tscn").instantiate()
		new_tower.position = build_location
		new_tower.built = true
		new_tower.towertype = build_type
		new_tower.animcategory = GameData.tower_data[build_type]["animcategory"]
		map_node.get_node("Towers").add_child(new_tower, true)
		
		# mark tile as occupied with transparent tile
		map_node.get_node("TowerExclusion").set_cell(build_tile, transparent_tile, transparent_tile_id)
		
		## deduct cash
		## update cash label

##
## WAVE FUNCTIONS
##

func start_next_wave() -> void:
	var wave_data = retrieve_wave_data()
	await(get_tree().create_timer(0.2)).timeout # don't start immediately
	spawn_enemies(wave_data)

func retrieve_wave_data() -> Array:
	var wave_data = [["blue_tank",1.0],["blue_tank",1.0],["blue_tank",1.5]]
	current_wave += 1
	enemimies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data: Array) -> void:
	for i in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instantiate()
		map_node.get_node("Path").add_child(new_enemy, true)
		await(get_tree().create_timer(i[1])).timeout
