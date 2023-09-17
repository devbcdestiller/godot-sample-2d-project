extends Node

@export var enemy_scene: PackedScene
var score
func _ready():
	new_game()


func game_over():
	$score_timer.stop()
	$mob_timer.stop()


func new_game():
	score = 0
	$player.start($start_position.position)
	$start_timer.start()


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


func _on_start_timer_timeout():
	$mob_timer.start()
	$score_timer.start()
