extends Resource
class_name InventoryData


@export var slot_data: Array[SlotData]

signal inventory_interact(inventory_data: InventoryData, index: int, button: int)
signal inventory_updated(inventory_data: InventoryData)


func grab_slot_data(index: int) -> SlotData:
	var data = slot_data[index]

	if data:
		slot_data[index] = null
		inventory_updated.emit(self)
		return data
	else:
		return null


func drop_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	var data = slot_data[index]

	var return_slot_data: SlotData
	if data and data.can_fully_merge_with(grabbed_slot_data):
		data.fully_merge_with(grabbed_slot_data)
	else:
		slot_data[index] = grabbed_slot_data
		return_slot_data = data

	inventory_updated.emit(self)
	return return_slot_data


func drop_single_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	var data = slot_data[index]

	if not data:
		slot_data[index] = grabbed_slot_data.create_single_slot_data()
	elif data.can_merge_with(grabbed_slot_data):
		data.fully_merge_with(grabbed_slot_data.create_single_slot_data())

	inventory_updated.emit(self)

	if grabbed_slot_data.quantity > 0:
		return grabbed_slot_data
	else:
		return null


func on_slot_clicked(index: int, button: int) -> void:
	inventory_interact.emit(self, index, button)
