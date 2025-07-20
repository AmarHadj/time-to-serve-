extends AnimatedSprite2D

var object = "meal"
@onready var interaction_area: CollisionShape2D = $Area2D/CollisionShape2D
@export var is_tv: bool
@onready var money: Sprite2D = $Money
@onready var plate_sound: AudioStreamPlayer2D = $PlateSound

var meal_number

func _process(_delta: float) -> void:
	if Singleton.client_is_finished:
		if !is_tv:
			finished_meal()
		if is_tv and Singleton.tv_time:
			finished_meal()
	
	if !Singleton.waiter_has_meal and !Singleton.client_is_eating and !is_tv:
		deactivate_area(false)
	elif !is_tv:
		deactivate_area(true)

	if is_tv and Singleton.tv_time:
		if !Singleton.waiter_has_meal and !Singleton.client_is_eating:
			deactivate_area(false)
		else :
			deactivate_area(true)

func deactivate_area(boolean):
	interaction_area.set_deferred("disabled", boolean)


func set_meal(number):
	meal_number = number
	self.play("Meal" + str(number))

func get_object_name():
	return object

func set_money(boolean):
	money.visible = boolean
	
func play_plate_sound():
	plate_sound.play()
	
func finished_meal():
	self.play("FinishedMeal")
	if interaction_area.is_disabled():
		set_money(false)
	elif !interaction_area.is_disabled() and meal_number !=1:
		set_money(true)
