extends Node2D
@onready var marker: Marker2D = $Marker2D
@onready var interaction_area: Area2D = $Area2D

var object = "table"

func _process(delta: float) -> void:
	if Singleton.has_meal:
		activate_area()
	else:
		deactivate_area()

func deactivate_area():
	interaction_area.set_deferred("disabled", true)
	
func activate_area():
	interaction_area.set_deferred("disabled", false)
	
func put_meal_on_table(meal):
	meal.global_position = marker.global_position

func get_object_name():
	return object
