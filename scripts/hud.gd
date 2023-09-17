extends CanvasLayer

signal start_game


func show_message(text):
	$message.text = text
	$message.show()
	$message_timer.start()


func show_game_over():
	show_message("Deez Nuts!")
	await $message_timer.timeout
	
	$message.text = "Dodge Deez!"
	$message.show()
	
	await get_tree().create_timer(1.0).timeout
	$start_button.show()


func update_score(score):
	$score_label.text = str(score)


func _on_start_button_pressed():
	$start_button.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$message.hide()
