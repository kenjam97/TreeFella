extends CharacterBody3D


@export_subgroup("Properties")
@export var mouse_sensitivity: float = 0.15
@export var gamepad_sensitivity: float = 0.075

@export var inventory_data: InventoryData

@onready var camera: Camera3D = $Camera
@onready var character_mover: Node3D = $CharacterMover
@onready var interact_ray: RayCast3D = $Camera/InteractRay

signal toggle_inventory()

var current_tool: GatherableResource.ToolType = GatherableResource.ToolType.AXE


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(_delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var move_direction: Vector3 = (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()

	character_mover.set_move_direction(move_direction)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()

	if Input.is_action_just_pressed("interact"):
		interact()

	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED :
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		camera.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -89, 89)


func interact() -> void:
	if interact_ray.is_colliding():

		var collider: Object = interact_ray.get_collider()
#
		while collider and not collider is ResourceNode:
			collider = collider.get_parent()
#
		if collider and collider.has_method("interact"):
			collider.interact(current_tool)


func _on_resource_node_give_resource(item: ItemData) -> void:
	print(item.name)
