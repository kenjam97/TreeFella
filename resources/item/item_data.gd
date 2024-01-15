extends Resource
class_name ItemData


enum ItemType {
	EQUIPMENT,
	CONSUMABLE,
	USEABLE
}

@export var name: String = ""
@export_multiline var description: String = ""
@export var type: ItemType
@export var stackable: bool = false
@export var texture: Texture
