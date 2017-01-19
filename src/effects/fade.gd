
extends Polygon2D

signal done_fade_out()
signal done_fade_in()

onready var w = get_viewport().get_rect().size.width
onready var h = get_viewport().get_rect().size.height
onready var tween = get_node("tween")
var opaque = true
var fading_in = false
var fading_out = false

func _ready():
  reset_color()
  change_alpha(1)
  set_polygon([
    Vector2(0, 0),
    Vector2(w, 0),
    Vector2(w, h),
    Vector2(0, h),
  ])

func fade_out(time):
  tween.interpolate_method(self, "change_alpha", 0, 1, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
  tween.start()
  fading_out = true
  yield(tween, "tween_complete")
  emit_signal("done_fade_out")
  fading_out = false
  opaque = true

func fade_in(time):
  tween.interpolate_method(self, "change_alpha", 1, 0, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
  tween.start()
  fading_in = true
  yield(tween, "tween_complete")
  emit_signal("done_fade_in")
  fading_in = false
  opaque = false

func start(total_time):
  fade_out(total_time / 2)
  yield(self, "done_fade_out")
  fade_in(total_time / 2)

func reset_color():
  set_color(Color(0, 0, 0, 0))

func change_alpha(a):
  var color = get_color()
  set_color(Color(color.r, color.g, color.b, a))

func is_opaque():
  return opaque

func is_fading_in():
  return fading_in

func is_fading_out():
  return fading_in

func is_mid_fade():
  return (fading_in or fading_out)
