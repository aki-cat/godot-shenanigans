
extends "res://classes/gamestate.gd"

export (float) var wait_time_per_image

signal done_showcase()

onready var timer = get_node("timer")
onready var images = get_node("images")
var current_img

func _ready():
  timer.set_wait_time(wait_time)

func setup_timer():
  yield(self, "done_showcase")
  fade_to_gamestate("menu")
