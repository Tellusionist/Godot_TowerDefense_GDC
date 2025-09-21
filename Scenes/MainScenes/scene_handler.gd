extends Node

func _ready() -> void:
	get_node("MainMenu/M/VB/NewGame").pressed.connect(func(): on_new_game_pressed())
	get_node("MainMenu/M/VB/Quit").pressed.connect(func(): on_quit_pressed())

func on_new_game_pressed() -> void:
	# unload the main menu and instance the game scene handler
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/game_scene.tscn").instantiate()
	add_child(game_scene)

func on_quit_pressed() ->  void:
	get_tree().quit()
