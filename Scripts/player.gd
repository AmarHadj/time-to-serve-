extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var meal_holding_place: Marker2D = $MealHoldingPlace
@onready var meal_holding_place_2: Marker2D = $MealHoldingPlace2
@onready var collision_shape_2d: CollisionShape2D = $interactionZone/CollisionShape2D

const SPEED = 350.0 # put at 300 for final result
var is_serving = false
var serving_animation_str = ""
var meal_to_serve
var table_served


func _physics_process(_delta: float) -> void:

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
		if table_served:
			table_served.set_has_meal_on(false)
	else:
		meal_to_serve = meal
		serving_animation_str = ""
		is_serving = false
		if table_served:
			table_served.set_has_meal_on(true)
	
func verify_meal_animation():
	if meal_to_serve:
		if animated_sprite_2d.flip_h and is_serving:
			meal_to_serve.global_position = meal_holding_place_2.global_position
		elif !animated_sprite_2d.flip_h and is_serving:
			meal_to_serve.global_position = meal_holding_place.global_position
		
func put_meal_on_table(table):
	meal_to_serve.play_plate_sound()
	Singleton.waiter_has_meal = false
	Singleton.client_is_eating = true
	table_served = table
	table_served.put_meal_on_table(meal_to_serve)
	set_meal_to_serve(null)
		
func let_go_of_meal():
	table_served.set_has_meal_on(false)
	table_served = null
	meal_to_serve.queue_free()
	set_meal_to_serve(null)
	
