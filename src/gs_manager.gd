
extends Node

export (String, "splash", "start", "gameplay") var current_gamestate

func _ready():
  if current_gamestate:
    update()

func change_to(gs):
  current_gamestate = gs
  update()

func update():
  var new_gamestate = load("res://gamestates/" + current_gamestate + ".tscn").instance()

  # remove current gamestate
  if get_child_count() > 0:
    # check if current gamestate isn't already in use
    var currently_active = get_child(0)
    if currently_active.get_name() == new_gamestate.get_name():
      print("Gamestate already loaded.")
      return
    else:
      currently_active.queue_free()

  # add new gamestate
  add_child(new_gamestate)
