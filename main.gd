extends Node


@onready var player: CharacterBody3D = $World/Player
@onready var inventory_interface: Control = $World/UI/InventoryInterface


func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)


func toggle_inventory_interface() -> void:
	inventory_interface.visible = !inventory_interface.visible

	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
