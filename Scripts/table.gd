extends Node2D
@onready var marker: Marker2D = $Marker2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var object = "table"
var meal_on_table
var has_meal_on = false

func _process(delta: float) -> void:
	if Singleton.waiter_has_meal:
		set_zone(false)
	else:
		set_zone(true)
	if has_meal_on:
		meal_on_table.global_position = marker.global_position

func set_zone(boolean):
	collision_shape_2d.set_deferred("disabled", boolean)
	
func put_meal_on_table(meal):
	meal_on_table = meal
	has_meal_on = true

func get_object_name():
	return object
