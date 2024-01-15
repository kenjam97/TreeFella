extends Node3D

@export var tree_data: TreeResource


func interact(player_tool: GatherableResource.ToolType) -> void:
	if tree_data and tree_data.required_tool == player_tool:
		print("you gathered from the tree!")
		get_parent_node_3d().queue_free()
	else:
		print("you aren't using the correct tool!")
