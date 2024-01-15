extends Resource
class_name GatherableResource


enum ToolType {
	NONE,
	AXE,
	PICKAXE
}

@export var required_level: int = 1
@export var xp_reward: int = 10
@export var required_tool: ToolType = ToolType.NONE
@export var untapped_resource_scene: PackedScene
@export var tapped_resource_scene: PackedScene
@export_range (0, 60) var respawn_seconds: int = 5
@export var drop_item: ItemData


func can_gather(player_tool: ToolType) -> bool:
	return player_tool == required_tool
