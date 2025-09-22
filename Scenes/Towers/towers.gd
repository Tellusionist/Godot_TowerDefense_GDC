extends Node2D

var towertype
var enemy_array = []
var built = false
var enemy
var readyToFire = true


func _ready() -> void:
	# set the tower parameters based on the game data references
	if built:
		self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameData.tower_data[towertype]["range"]
		

func _physics_process(delta: float) -> void:
	if enemy_array.size() !=0 and built:
		select_enemy()
		turn()
		if readyToFire:
			fire()
	else:
		enemy = null
	
func turn() -> void:
	# using mouse position for now to test
	get_node("Turret").look_at(enemy.position)

func select_enemy() -> void:
	var enemy_progress_array = []
	
	# check to see how far the enemey has progress on the path
	for i in enemy_array:
		enemy_progress_array.append(i.progress)
	
	# see which enemy is the furthers along
	var max_progress = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_progress)

	# set the current enemy to who is furthest down the path
	enemy = enemy_array[enemy_index]

func fire() -> void:
	readyToFire = false
	enemy.on_hit(GameData.tower_data[towertype]["damage"])
	await(get_tree().create_timer(GameData.tower_data[towertype]["rof"])).timeout
	readyToFire = true

func _on_range_body_entered(body: Node2D) -> void:
	# add enemies who have entered the range to the possible enemies list
	enemy_array.append(body.get_parent())

func _on_range_body_exited(body: Node2D) -> void:
	# remove any enemies that have left the range
	enemy_array.erase(body.get_parent())
