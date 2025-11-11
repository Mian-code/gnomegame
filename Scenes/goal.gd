extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		print("🏆 You found the goal!")
		_win_game()

func _win_game():
	var nodes = get_tree().get_nodes_in_group("win_ui")
	if nodes.size() > 0:
		var ui = nodes[0]
		ui.show_win_screen()
	else:
		# fallback: print or reload
		print("Win UI not found, reloading scene.")
		get_tree().reload_current_scene()
