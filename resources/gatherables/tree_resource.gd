extends GatherableResource
class_name TreeResource


enum TreeType {
	NORMAL,
	OAK
}

@export var tree_type: TreeType = TreeType.NORMAL

func _ready() -> void:
	required_tool = ToolType.AXE
