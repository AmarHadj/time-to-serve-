extends Node2D
var has_waiter_close
var object = "meal_drop"
var meal_number

@onready var timer: Timer = $Timer
@onready var interaction_area: CollisionShape2D = $Area2D/CollisionShape2D
@onready var portrait: Sprite2D = $portrait_with_wig
@export var drop_place: Marker2D

func _process(_delta: float) -> void:
	if Singleton.activate_meal_drop:
		deactivate_area(false)
	else:
		deactivate_area(true)
	if timer.get_time_left() < 0.8 and Singleton.time_to_cook:
		Singleton.time_to_cook = false
	if timer.get_time_left() < 3 and Singleton.time_to_cook and meal_number == 2:
		Singleton.wig_remove = true
		portrait = $portrait_without_wig


func deactivate_area(boolean):
	interaction_area.set_deferred("disabled", boolean)
	
	
func get_object_name():
	return object
	
func prepare_meal(Client_number):
	meal_number = Client_number
	Singleton.time_to_cook = true
	timer.start()

func _on_timer_timeout() -> void:
	Singleton.create_meal(drop_place, meal_number)
	

func get_portrait():
	return portrait
