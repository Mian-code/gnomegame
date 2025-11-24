extends CanvasLayer

var dragging = false
var start_pos = Vector2.ZERO
var joy_vector = Vector2.ZERO

@onready var knob = $JoystickBase/JoystickKnob
@onready var base = $JoystickBase

func _ready():
	knob.position = base.position

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
			start_pos = event.position
		else:
			dragging = false
			joy_vector = Vector2.ZERO
			knob.position = base.position

	if event is InputEventScreenDrag and dragging:
		var offset = event.position - base.position
		joy_vector = offset.normalized()
		var distance = min(offset.length(), base.size.x/2)
		knob.position = base.position + joy_vector * distance
