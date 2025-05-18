extends Control

func AssignText(title: String, description: String, cost: String):
	$"CanvasLayer/PopupPanel/VBoxContainer/Label".text = title
	$"CanvasLayer/PopupPanel/VBoxContainer/Label2".text = description
	$"CanvasLayer/PopupPanel/VBoxContainer/Label3".text = cost
	
func ItemPopup(slot: Rect2i):
	
	var mouse_pos = get_viewport().get_mouse_position()
	var correction
	var padding = 4
	if mouse_pos.x <= get_viewport_rect().size.x/2:
		correction = Vector2i(slot.size.x + padding, 0)
	else:
		correction = -Vector2i($"CanvasLayer/PopupPanel".size.x + padding,0)
	$"CanvasLayer/PopupPanel".popup(Rect2i(slot.position + correction, $"CanvasLayer/PopupPanel".size))
	
func HidePopup():
	$"CanvasLayer/PopupPanel".hide()
