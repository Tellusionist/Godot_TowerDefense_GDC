extends Node

func _ready() -> void:
	load_main_menu()

func load_main_menu() -> void:
	get_node("main_menu/M/VB/NewGame").pressed.connect(func(): on_new_game_pressed())
	get_node("main_menu/M/VB/Quit").pressed.connect(func(): on_quit_pressed())

func on_new_game_pressed() -> void:
	# unload the main menu and instance the game scene handler
	get_node("main_menu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/game_scene.tscn").instantiate()
	game_scene.connect("game_finished", unload_game)
	add_child(game_scene)

func on_quit_pressed() ->  void:
	get_tree().quit()

func unload_game() -> void:
	$GameScene.queue_free()
	var main_menu = load("res://Scenes/UIScenes/main_menu.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()
	
