extends Node3D
class_name ResourceNode


signal give_resource(item: ItemData)

@onready var respawn_timer: Timer = $RespawnTimer

@export var resource_data: GatherableResource

var is_tapped: bool = false


func _ready() -> void:
	if resource_data and resource_data.untapped_resource_scene:
		var untapped_resource_instance: Node = resource_data.untapped_resource_scene.instantiate()
		add_child(untapped_resource_instance)

	respawn_timer.timeout.connect(on_respawn_timer_timeout)


func interact(player_tool: GatherableResource.ToolType) -> void:
	if resource_data and resource_data.can_gather(player_tool) and not is_tapped:
		for child: Node in get_children():
			if child != respawn_timer:
				remove_child(child)
				child.queue_free()

		if resource_data.tapped_resource_scene:
			if resource_data.drop_item:
				give_resource.emit(resource_data.drop_item)

			var tapped_resouce_instance: Node = resource_data.tapped_resource_scene.instantiate()
			add_child(tapped_resouce_instance)
			is_tapped = true
			respawn_timer.start(resource_data.respawn_seconds)


func on_respawn_timer_timeout() -> void:
	for child: Node in get_children():
		if child != respawn_timer:
			remove_child(child)
			child.queue_free()

	if resource_data and resource_data.untapped_resource_scene:
		var untapped_resource_instance: Node = resource_data.untapped_resource_scene.instantiate()
		add_child(untapped_resource_instance)

	is_tapped = false
