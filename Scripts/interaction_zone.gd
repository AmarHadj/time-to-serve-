extends Area2D

@onready var portrait: Sprite2D = $"../portrait"

var has_touched_client = false
var client_Touched = false
var discussion_progress = 0

func _on_area_entered(area: Area2D) -> void:
	has_touched_client = true
	client_Touched = area.get_parent()

func _on_area_exited(area: Area2D) -> void:
	has_touched_client = false
	client_Touched = null

func _input(event):
	if has_touched_client and event.is_action_pressed("ui_accept"):
		if discussion_progress % 2 == 0:
			Singleton.emit_signal("display_dialog", client_Touched.get_text_key(), portrait)
		elif discussion_progress % 2 == 1:
			Singleton.emit_signal("display_dialog", client_Touched.get_text_key(), client_Touched.get_portrait())
		discussion_progress += 1
