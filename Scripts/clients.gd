extends CharacterBody2D

var is_in_waiter_range = false

func _on_interaction_zone_area_entered(area: Area2D) -> void:
	is_in_waiter_range = true

func _on_interaction_zone_area_exited(area: Area2D) -> void:
	is_in_waiter_range = false
	
func get_is_in_waiter_range():
	return is_in_waiter_range
	
func _process(delta: float) -> void:
	pass
