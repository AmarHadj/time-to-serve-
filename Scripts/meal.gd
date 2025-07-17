extends AnimatedSprite2D

var object = "meal"
@onready var interaction_area: CollisionShape2D = $Area2D/CollisionShape2D


func _process(delta: float) -> void:
	if Singleton.client_is_finished:
		self.play("FinishedMeal")
	
	if !Singleton.waiter_has_meal and !Singleton.client_is_eating:
		deactivate_area(false)
	else:
		deactivate_area(true)

func deactivate_area(boolean):
	interaction_area.set_deferred("disabled", boolean)

func set_meal(meal_number):
	self.play("Meal" + str(meal_number))

func get_object_name():
	return object
