extends Node

var all_saves: Dictionary

func _ready() -> void:
	all_saves = GameData._load_all_saves()
	load_main_menu()
	

func load_main_menu() -> void:
	# "activate" slots if a game has been saved before
	for slot in ['1','2','3']:
		if all_saves.has(slot):
			get_node("main_menu/M/VB/VB/HB/" + slot).self_modulate = Color("ffffff")
	
	get_node("main_menu/M/VB/NewGame").pressed.connect(func(): on_new_game_pressed())
	get_node("main_menu/M/VB/LoadGame").pressed.connect(func(): on_load_game_pressed())
	get_node("main_menu/M/VB/Quit").pressed.connect(func(): on_quit_pressed())

func on_new_game_pressed() -> void:
	# unload the main menu and instance the game scene handler
	get_node("main_menu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/game_scene.tscn").instantiate()
	game_scene.connect("game_finished", unload_game)
	add_child(game_scene)

func on_load_game_pressed() -> void:
	if get_node("main_menu/M/VB/Spacer").visible == true:
		get_node("main_menu/M/VB/VB").visible = true
		get_node("main_menu/M/VB/Spacer").visible = false
	else:
		get_node("main_menu/M/VB/VB").visible = false
		get_node("main_menu/M/VB/Spacer").visible = true

func on_quit_pressed() ->  void:
	get_tree().quit()

func unload_game() -> void:
	$GameScene.queue_free()
	var main_menu = load("res://Scenes/UIScenes/main_menu.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()
