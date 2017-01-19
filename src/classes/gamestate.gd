
extends Node2D

const FADE_TIME = 1.0

onready var fade = get_node("/root/main/effects/fade")
onready var manager = get_node("/root/main/gamestate")

func change_gamestate(gs_name):
  manager.change_to(gs_name)
