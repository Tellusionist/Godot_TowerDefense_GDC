extends PathFollow2D

@export var enemytype: String = "blue_tank"
var speed = GameData.enemy_data[enemytype]["speed"]
var hp = GameData.enemy_data[enemytype]["hp"]


@onready var health_bar = get_node("HealthBar")

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
	hp -= damage
	health_bar.value = hp
	print("enemy hit with " + str(damage) + " damage | new hp: " + str(hp))
	if hp <=0:
		on_destroy()
		print("enemy destroyed")

func on_destroy() -> void:
	self.queue_free()
