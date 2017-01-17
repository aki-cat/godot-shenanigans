
extends Polygon2D

signal fade_out()
signal fade_mid()
signal fade_in()

onready var w = get_viewport().get_rect().size.width
onready var h = get_viewport().get_rect().size.height
onready var tween = Tween.new()

func _ready():
  add_child(tween)
  reset_color()
  set_polygon([
    Vector2(0, 0),
    Vector2(w, 0),
    Vector2(w, h),
    Vector2(0, h),
  ])

func fade_out(time):
  tween.interpolate_method(self, "change_alpha", 0, 1, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
  tween.start()
  emit_signal("fade_out")

func fade_in(time):
  tween.interpolate_method(self, "change_alpha", 1, 0, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
  tween.start()
  emit_signal("fade_mid")
  yield(tween, "tween_complete")
  emit_signal("fade_in")

func start(total_time):
  fade_out(total_time / 2)
  yield(tween, "tween_complete")
  fade_in(total_time / 2)

func reset_color():
  set_color(Color(0, 0, 0, 0))

func change_alpha(a):
  var color = get_color()
  set_color(Color(color.r, color.g, color.b, a))
