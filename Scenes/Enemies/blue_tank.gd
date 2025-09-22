extends PathFollow2D

@export var enemytype: String = "blue_tank"
var speed = GameData.enemy_data[enemytype]["speed"]
var hp = GameData.enemy_data[enemytype]["hp"]


@onready var health_bar = $HealthBar
@onready var impact_area = $Impact
var projectile_impact = preload("res://Scenes/SupportScenes/projectile_impact.tscn")

func _ready() -> void:
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.top_level = true # disconnect healthbar from enemy

func _process(delta) -> void:
	move(delta)

func move(delta):
	set_progress(get_progress() + speed * delta)
	health_bar.position = position # track with enemy

func on_hit(damage:int) -> void:
	impact()
	hp -= damage
	health_bar.value = hp
	print("enemy hit with " + str(damage) + " damage | new hp: " + str(hp))
	if hp <=0:
		on_destroy()
		print("enemy destroyed")

func impact() -> void:
	randomize()
	var x_pos = randi() %31
	randomize()
	var y_pos = randi() %31
	var impact_location = Vector2(x_pos, y_pos)
	var new_impact = projectile_impact.instantiate()
	new_impact.position = impact_location
	impact_area.add_child(new_impact)


func on_destroy() -> void:
	$CharacterBody2D.queue_free()
	await(get_tree().create_timer(0.2)).timeout
	self.queue_free()
