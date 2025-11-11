extends Node2D

@export var goal_scene: PackedScene        # Drag your Goal.tscn here in the Inspector
@export var spawn_area: Rect2 = Rect2(-500, -500, 1000, 1000)  # Adjust for your maze size

func _ready():
	randomize()  # Ensures new random spawn each time
	_spawn_goal()

func _spawn_goal():
	if goal_scene == null:
		push_error("⚠️ No goal scene assigned!")
		return

	var goal = goal_scene.instantiate()
	add_child(goal)

	var random_x = randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x)
	var random_y = randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)

	goal.global_position = Vector2(random_x, random_y)
	print("🎯 Goal spawned at:", goal.global_position)
