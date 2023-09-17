extends Area2D

signal hit
@export var player_speed = 400
@export var movement_speed = 1
var screen_size


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += movement_speed
	if Input.is_action_pressed("move_up"):
		velocity.y -= movement_speed
	if Input.is_action_pressed("move_right"):
		velocity.x += movement_speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= movement_speed

	if velocity.length() > 0:
		velocity = velocity.normalized() * player_speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
