extends CharacterBody2D


const SPEED = 300.0
var direction

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wig: Sprite2D = $wig


func _physics_process(delta: float) -> void:

	if Singleton.tv_time and global_position.x > -92:
		move(-1, true)
		
	elif Singleton.time_to_cook and global_position.x > -92 and !Singleton.tv_time:
		move(-1, true)
	
	elif !Singleton.time_to_cook and global_position.x < 132 and !Singleton.tv_time:
		move(1, false)
		
	else:
		if global_position.x < 0:
			Singleton.chef_is_here = false
		elif global_position.x > 0:
			Singleton.chef_is_here = true
			
		if Singleton.wig_remove:
			wig.texture = null
			
		animated_sprite_2d.play("Idle")
		velocity.x = 0
		


	move_and_slide()
	
func move(direction, flip):
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = flip
		wig.flip_h = flip
		animated_sprite_2d.play("Walk")
