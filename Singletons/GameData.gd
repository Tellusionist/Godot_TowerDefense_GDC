extends Node

var valid_color = Color("adff4545")
var error_color = Color("ff00003c")

var tower_data = {
        "gun_t1"    : {"damage": 20, "rof": 1.0, "range": 350},
        "gun_t2"    : {"damage": 40, "rof": 1.0, "range": 350},
        "missle_t1" : {"damage": 25, "rof": 3.0, "range": 550},
            }
var enemy_data = {
        "blue_tank" : {"hp": 50, "speed": 150},
                }