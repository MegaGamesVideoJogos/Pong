extends CharacterBody2D

class_name Player

enum PLAYER {
	P1,
	P2,
}

const SPEED = 300.0
@export var side: PLAYER = PLAYER.P1

var input: Array

func _ready():
	input = ["p1_up", "p1_down"] if side == PLAYER.P1 else ["p2_up", "p2_down"]

func _physics_process(_delta):
	var direction = get_axis()
	
	velocity.y = direction * SPEED

	move_and_slide()

func get_axis():
	var axis = 0
	if Input.is_action_pressed(input[0]): 
		axis += -1
	if Input.is_action_pressed(input[1]):
		axis += 1
	return axis
