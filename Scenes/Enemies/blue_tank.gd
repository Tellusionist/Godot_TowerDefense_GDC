extends PathFollow2D

var speed = 150

func _process(delta) -> void:
    move(delta)

func move(delta):
    set_progress(get_progress() + speed * delta)