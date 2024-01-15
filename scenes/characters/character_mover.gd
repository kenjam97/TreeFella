extends Node3D


@export_subgroup("Properties")
@export var max_speed: float = 5.0
@export var move_acceleration: float = 2.0
@export var stop_drag: float = 0.7

var character_body: CharacterBody3D
var move_drag: float = 0.0
var move_direction: Vector3


func _ready() -> void:
	character_body = get_parent()
	move_drag = float(move_acceleration) / max_speed


func set_move_direction(new_move_direction: Vector3) -> void:
	move_direction = new_move_direction


func _physics_process(_delta: float) -> void:
	var drag: float = move_drag
	if move_direction.is_zero_approx():
		drag = stop_drag

	var flat_velocity: Vector3 = character_body.velocity
	flat_velocity.y = 0.0
	character_body.velocity += move_acceleration * move_direction - flat_velocity * drag

	character_body.move_and_slide()
