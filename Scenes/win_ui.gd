extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var label = $Label
@onready var button = $Button

func _ready():
	visible = false
	# ensure fully transparent initially
	color_rect.modulate = Color(0, 0, 0, 0)
	label.modulate = Color(1, 1, 1, 0)
	button.modulate = Color(1, 1, 1, 0)

	button.pressed.connect(_on_restart_pressed)

func show_win_screen():
	visible = true
	# Fade the overlay to alpha 0.7 and fade in label+button
	var t = create_tween()
	t.tween_property(color_rect, "modulate:a", 0.7, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	t.tween_property(label, "modulate:a", 1.0, 0.6).set_delay(0.2)
	t.tween_property(button, "modulate:a", 1.0, 0.6).set_delay(0.2)

func _on_restart_pressed():
	get_tree().reload_current_scene()
