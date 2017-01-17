
extends Node2D

const FADE_TIME = 2.0

onready var fade = get_node("/root/main/effects/fade")
onready var manager = get_node("/root/main/gamestate")

func fade_to_gamestate(gs_name):
  fade.call_deferred("start", FADE_TIME)
  yield(fade, "fade_mid")
  manager.change_to(gs_name)
