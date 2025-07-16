extends CharacterBody2D
@onready var button: Sprite2D = $space_bar
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var meal_holding_place: Marker2D = $MealHoldingPlace
@onready var meal_holding_place_2: Marker2D = $MealHoldingPlace2

const SPEED = 300.0
var has_touched_client = false
var is_serving = false
var serving_animation_str = ""
var meal_to_serve


func _process(delta: float) -> void:
	if has_touched_client and !Singleton.need_meal and !Singleton.in_dialogue:
		button.visible = true
	else :
		button.visible = false
		
		
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
	meal_to_serve = meal
	serving_animation_str = "WithMeal"
	is_serving = true
	
	
func _on_interaction_zone_area_entered(area: Area2D) -> void:
	has_touched_client = true
	
func _on_interaction_zone_area_exited(area: Area2D) -> void:
	has_touched_client = false
	
func verify_meal_animation():
	if animated_sprite_2d.flip_h and is_serving:
		meal_to_serve.global_position = meal_holding_place_2.global_position
	elif !animated_sprite_2d.flip_h and is_serving:
		meal_to_serve.global_position = meal_holding_place.global_position
func put_meal_on_table(table):
		table.put_meal_on_table(meal_to_serve)
