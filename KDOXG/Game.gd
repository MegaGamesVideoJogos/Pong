extends Node2D

@export var ball: PackedScene

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if $Ball.velocity.is_zero_approx():
			$Ball.start()

func _ready():
	randomize()
	$Ball.reset($StartPosition.global_position, get_random_direction())
	$BGM.volume_db = linear_to_db(0.25)
	$BGM.play()
	$Paddle.volume_db = linear_to_db(2)
	$Wall.volume_db = linear_to_db(4)

func _process(delta):
	$UI/P1Score.text = str(Main.p1_score)
	$UI/P2Score.text = str(Main.p2_score)

func get_random_direction():
	var d1 = float(1 if randi() % 2 else -1)
	var d2 = float(1 if randi() % 2 else -1)
	var r = Vector2((randf() * 0.5 + 0.25) * d1, (randf() * 0.5 + 0.25) * d2)
	return r

func _on_field_body_exited(body):
	if $Field.global_position < body.global_position:
		Main.p1_score += 1
	else:
		Main.p2_score += 1
	$Score.play()
	body.reset($StartPosition.global_position, get_random_direction())
