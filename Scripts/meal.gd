extends AnimatedSprite2D

var object = "meal"

func set_meal(meal_number):
	self.play("Meal" + str(meal_number))

func get_object_name():
	return object
