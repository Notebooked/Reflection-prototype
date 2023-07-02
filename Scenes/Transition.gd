extends ColorRect

func transition_to(target: String) -> void:
	# Plays the Fade animation and wait until it finishes
	$AnimationPlayer.play("Fade")
	await $AnimationPlayer.animation_finished
	# Changes the scene
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("Fade")
