extends CharacterBody2D


const SPEED = 400.0
var text_key
var object = "Boss"
var direction

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var portrait: Sprite2D = $portrait
@onready var hit_box: CollisionShape2D = $StaticBody2D/CollisionShape2D

func _ready() -> void:
	text_key = "Boss"
	animated_sprite_2d.play("Idle")
	animated_sprite_2d.flip_h = true
func _physics_process(delta: float) -> void:
	
	if Singleton.game_start and global_position.y < 492:
		direction = 1
		velocity.y = direction * SPEED
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("Walk")
		hit_box.set_deferred("disabled", true)
	elif global_position.y > 492:
		self.queue_free()
		
	move_and_slide()

func get_object_name():
	return object

func set_object_name(object_name):
	object = object_name
	
func get_portrait():
	return portrait
	
func get_text_key():
	return text_key
