extends Node2D
var has_waiter_close
var object = "meal_drop"
var meal_number

@onready var timer: Timer = $Timer
@onready var interaction_area: CollisionShape2D = $Area2D/CollisionShape2D
@export var drop_place: Marker2D

func _process(delta: float) -> void:
	if Singleton.need_meal:
		activate_area()
	else:
		deactivate_area()

func deactivate_area():
	interaction_area.set_deferred("disabled", true)
	
func activate_area():
	interaction_area.set_deferred("disabled", false)
	
func get_object_name():
	return object
	
func prepare_meal(Client_number):
	meal_number = Client_number
	timer.start()

func _on_timer_timeout() -> void:
	Singleton.create_meal(drop_place, meal_number)
