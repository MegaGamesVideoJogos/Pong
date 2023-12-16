extends CharacterBody2D

class_name Ball

const SPEED = 300.0
var direction = Vector2.ZERO
var difficulty = 0.0

@onready var stage = get_parent()

func _ready():
	set_physics_process(false)

func _physics_process(_delta):

	velocity = direction * (SPEED + difficulty)
	
	move_and_slide()
	
	on_collision()

func start():
	set_physics_process(true)

func reset(pos: Vector2, dir: Vector2):
	velocity = Vector2.ZERO
	global_position = pos
	difficulty = 0
	direction = dir
	set_physics_process(false)

func on_collision():
	if is_on_ceiling() or is_on_floor():
		direction.y *= -1
		stage.get_node("Wall").play()
		return
	if get_slide_collision_count() >= 1:
		direction.x *= -1
		stage.get_node("Paddle").play()

func _on_difficulty_timer_timeout():
	difficulty += 30
