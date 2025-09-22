extends Node

var valid_color = Color("adff4545")
var error_color = Color("ff00003c")
var SAVE_FILE = "user://save_data.json"

var tower_data = {
        "gun_t1"    : {"damage": 10, "rof": 1.0, "range": 350, "animcategory": "immediate"},
        "gun_t2"    : {"damage": 20, "rof": 1.0, "range": 350, "animcategory": "immediate"},
        "missle_t1" : {"damage": 25, "rof": 3.0, "range": 550, "animcategory": "delay"},
            }
var enemy_data = {
        "blue_tank" : {"hp": 35, "speed": 150, "damage": 20, "enemy_money": 10},
                }

# --- Persistent save data ---
var save_file_path := "user://savegame.json"

# --- Runtime session data ---
var current_slot: int = 1
var current_money: int = 0
var current_base_health: int = 100
var current_level: int = 1
var towers_data: Array = []


# --- Core Functions ---

func new_game(slot: int) -> void:
	current_slot = slot
	current_money = 100         # starting money
	current_base_health = 100   # starting health
	current_level = 1
	towers_data = []
	save_game()                 # Save right away so we can resume later


func load_game(slot: int) -> void:
	var all_saves = _load_all_saves()
	if all_saves.has(str(slot)):
		var data = all_saves[str(slot)]
		current_slot = slot
		current_money = data.get("money", 0)
		current_base_health = data.get("base_health", 100)
		current_level = data.get("level", 1)
		towers_data = data.get("towers", [])
	else:
		push_warning("No save found for slot %d, starting new game." % slot)
		new_game(slot)


func save_game() -> void:
	var all_saves = _load_all_saves()
	all_saves[str(current_slot)] = {
		"money": current_money,
		"base_health": current_base_health,
		"level": current_level,
		"towers": towers_data,
	}
	_save_all_saves(all_saves)


# --- Money / Health Management ---

func add_money(amount: int) -> void:
	current_money += amount


func damage_base(amount: int) -> void:
	current_base_health = max(0, current_base_health - amount)


# --- Internal Helpers ---

func _load_all_saves() -> Dictionary:
	if not FileAccess.file_exists(save_file_path):
		return {}
	var file = FileAccess.open(save_file_path, FileAccess.READ)
	var data = file.get_as_text()
	file.close()
	return JSON.parse_string(data) if data != "" else {}


func _save_all_saves(data: Dictionary) -> void:
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data, "\t")) # pretty print with tabs
	file.close()
