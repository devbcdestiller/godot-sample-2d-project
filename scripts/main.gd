extends Node

@export var enemy_scene: PackedScene
var score


func game_over():
	$score_timer.stop()
	$mob_timer.stop()
	$hud.show_game_over()


func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$player.start($start_position.position)
	$start_timer.start()
	$hud.update_score(score)
	$hud.show_message("Ready!")


func _on_mob_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var enemy_spawn_location = get_node("enemy_path/enemy_spawn_location")
	enemy_spawn_location.progress_ratio = randf()
	var direction = enemy_spawn_location.rotation + PI / 2
	
	enemy.position = enemy_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)
	add_child(enemy)


func _on_score_timer_timeout():
	score += 1
	$hud.update_score(score)


func _on_start_timer_timeout():
	$mob_timer.start()
	$score_timer.start()
