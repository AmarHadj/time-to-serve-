extends Node2D
@onready var marker: Marker2D = $Marker2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var object = "table"
var meal_on_table
var has_meal_on = false

func _process(delta: float) -> void:
	if Singleton.waiter_has_meal:
		deactivate_zone(false)
	elif Singleton.client_is_finished || Singleton.client_need_table || Singleton.client_is_eating:
		deactivate_zone(true)
		
	if meal_on_table and has_meal_on:
		meal_on_table.global_position = marker.global_position

func deactivate_zone(boolean):
	collision_shape_2d.set_deferred("disabled", boolean)
	
func put_meal_on_table(meal):
	meal_on_table = meal

func get_object_name():
	return object
	
func set_has_meal_on(boolean):
	has_meal_on = boolean
