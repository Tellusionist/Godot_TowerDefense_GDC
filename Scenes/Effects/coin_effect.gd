extends Node2D

func _ready():
    $AnimationPlayer.play("spin_and_rise")
    $AnimationPlayer.animation_finished.connect(func(_anim_name): queue_free())
