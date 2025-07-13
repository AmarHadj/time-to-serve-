extends CharacterBody2D
@onready var button: Sprite2D = $space_bar
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
var has_touched_client = false
var client_Touched

func _process(delta: float) -> void:
	if has_touched_client:
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
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if directionX > 0:
		animated_sprite_2d.flip_h = false
		
	elif directionX < 0:
		animated_sprite_2d.flip_h = true
		
	if directionX == 0 and directionY == 0:
		animated_sprite_2d.play("Idle")
	else:
		animated_sprite_2d.play("Walk")

	move_and_slide()


func _on_interaction_zone_area_entered(area: Area2D) -> void:
	has_touched_client = true
	
func _on_interaction_zone_area_exited(area: Area2D) -> void:
	has_touched_client = false
