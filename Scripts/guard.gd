extends CharacterBody2D

@export var speed := 100.0
@export var patrol_parent_path: NodePath
var patrol_points: Array = []
var patrol_index := 0
var direction := Vector2.ZERO
var detected := false

func _ready():
	if patrol_parent_path != NodePath():
		var parent = get_node(patrol_parent_path)
		for child in parent.get_children():
			if child is Marker2D:
				patrol_points.append(child.global_position)

	var vision = $Vision
	if vision:
		vision.body_entered.connect(_on_vision_body_entered)
		vision.body_exited.connect(_on_vision_body_exited)

func _physics_process(delta: float) -> void:
	if detected:
		return  # stop when player seen

	if patrol_points.size() == 0:
		return

	var target = patrol_points[patrol_index]
	direction = (target - global_position).normalized()
	var motion = direction * speed * delta

	var collision = move_and_collide(motion)
	if collision:
		var hit = collision.get_collider()
		if hit.name == "Player":
			print("💀 Player touched the guard!")
			_restart_level()
			return

	if global_position.distance_to(target) < 10:
		patrol_index = (patrol_index + 1) % patrol_points.size()

func _on_vision_body_entered(body):
	if body.name == "Player":
		print("🚨 Player seen by guard!")
		detected = true
		_restart_level()

func _on_vision_body_exited(body):
	if body.name == "Player":
		detected = false

# 🔁 Restart helper
func _restart_level():
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()
