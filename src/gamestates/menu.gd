
extends "res://classes/gamestate.gd"

onready var timer = Timer.new()

func _ready():
  timer.set_one_shot(true)
  add_child(timer)
  change_gamestate()

func change_gamestate():
  timer.set_wait_time(2.0)
  timer.start()
  yield(timer, "timeout")
  fade_to_gamestate("gameplay")
