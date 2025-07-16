extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var meal_holding_place: Marker2D = $MealHoldingPlace
@onready var meal_holding_place_2: Marker2D = $MealHoldingPlace2

const SPEED = 300.0
var is_serving = false
var serving_animation_str = ""
var meal_to_serve


func _physics_process(delta: float) -> void:

	var directionX := Input.get_axis("ui_left", "ui_right")
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var directionY := Input.get_axis("ui_up", "ui_down")
	if directionY:
		velocity.y = directionY * SPEED
		verify_meal_animation()
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if directionX > 0:
		animated_sprite_2d.flip_h = false
		
	elif directionX < 0:
		animated_sprite_2d.flip_h = true

		
	if directionX == 0 and directionY == 0 :
		verify_meal_animation()
		animated_sprite_2d.play("Idle"+serving_animation_str)
	else:
		verify_meal_animation()
		animated_sprite_2d.play("Walk"+serving_animation_str)

	move_and_slide()

func set_meal_to_serve(meal):
	if !is_serving:
		meal_to_serve = meal
		serving_animation_str = "WithMeal"
		is_serving = true
	else:
		meal_to_serve = meal
		serving_animation_str = ""
		is_serving = false
	
func verify_meal_animation():
	if animated_sprite_2d.flip_h and is_serving:
		meal_to_serve.global_position = meal_holding_place_2.global_position
	elif !animated_sprite_2d.flip_h and is_serving:
		meal_to_serve.global_position = meal_holding_place.global_position
		
func put_meal_on_table(table):
		Singleton.waiter_has_meal = false
		Singleton.client_is_eating = true
		table.put_meal_on_table(meal_to_serve)
		set_meal_to_serve(null)
