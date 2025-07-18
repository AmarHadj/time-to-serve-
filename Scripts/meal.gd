extends AnimatedSprite2D

var object = "meal"
@onready var interaction_area: CollisionShape2D = $Area2D/CollisionShape2D
@export var is_tv: bool
var meal_number

func _process(delta: float) -> void:
	if Singleton.client_is_finished:
		if !is_tv:
			self.play("FinishedMeal")
		if is_tv and Singleton.tv_time:
			self.play("FinishedMeal")
		
	
	if !Singleton.waiter_has_meal and !Singleton.client_is_eating and !is_tv:
		deactivate_area(false)
	elif !is_tv:
		deactivate_area(true)

	if is_tv and Singleton.tv_time:
		if !Singleton.waiter_has_meal:
			deactivate_area(false)
		elif Singleton.tv_time:
			deactivate_area(true)

func deactivate_area(boolean):
	interaction_area.set_deferred("disabled", boolean)

func set_meal(number):
	meal_number = number
	self.play("Meal" + str(number))

func get_object_name():
	return object
