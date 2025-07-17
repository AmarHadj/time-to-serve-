extends CharacterBody2D


const SPEED = 300.0
var direction

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wig: Sprite2D = $wig


func _physics_process(delta: float) -> void:

	if Singleton.time_to_cook and global_position.x > -92:
		direction = -1
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = true
		wig.flip_h = true
		animated_sprite_2d.play("Walk")
	
	elif !Singleton.time_to_cook and global_position.x < 132:
		direction = 1
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = false
		wig.flip_h = false
		animated_sprite_2d.play("Walk")
	else:
		if Singleton.wig_remove:
			wig.texture = null
			
		animated_sprite_2d.play("Idle")
		velocity.x = 0
		


	move_and_slide()
