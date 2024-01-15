extends GatherableResource
class_name RockResource


enum RockType {
	COPPER
}

@export var rock_type: RockType = RockType.COPPER

func _ready() -> void:
	required_tool = ToolType.PICKAXE
