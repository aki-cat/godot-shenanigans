
extends "res://classes/gamestate.gd"

export (float) var wait_time_per_image

signal done_showing_all_images()

onready var timer = get_node("timer")
onready var images = get_node("images")

func _ready():
  hide_all()
  timer.set_one_shot(true)
  timer.set_wait_time(0.5)
  timer.start()
  yield(timer, "timeout")
  call_deferred("play")

func hide_all():
  for img in images.get_children():
    img.hide()

func play():
  var wait_time = wait_time_per_image / 3
  timer.set_wait_time(wait_time)
  for img in images.get_children():
    # fade in
    img.show()
    fade.fade_in(wait_time)
    yield(fade, "done_fade_in")
    # wait
    timer.start()
    yield(timer, "timeout")
    # fade out
    fade.fade_out(wait_time)
    yield(fade, "done_fade_out")
    img.hide()
  change_gamestate("menu")
  fade.fade_in(1.0)
