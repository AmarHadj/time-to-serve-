extends CharacterBody2D

var client_number
var dialogue_number
var table_assigned = false
var object = "client"
const SPEED = 300.0

var text_key
@onready var portrait: Sprite2D = $portrait
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var talk_zone: CollisionShape2D = $"interactionZone/talk zone"


func _ready() -> void:
	text_key = "Client"+str(client_number)
	portrait.texture = load("res://assets/art/characters/portrait/Client"+str(client_number)+"Portrait.png")
	animated_sprite_2d.play("Idle"+str(client_number))
	animated_sprite_2d.flip_h = true

func _physics_process(delta: float) -> void:
	if table_assigned and global_position.y > 201:
		hitbox.set_deferred("disabled", true)
		var direction := -1
		if direction:
			velocity.y = direction * SPEED
		if direction > 0:
			animated_sprite_2d.flip_h = false
			
		elif direction < 0:
			animated_sprite_2d.flip_h = true
			
		if direction == 0 :
			animated_sprite_2d.play("Idle"+str(client_number))
		else:
			animated_sprite_2d.play("Walk"+str(client_number))
			talk_zone.set_deferred("disabled", true)
	else :
		velocity.y = 0
		animated_sprite_2d.play("Idle"+str(client_number))
		hitbox.set_deferred("disabled", false)
		talk_zone.set_deferred("disabled", false)
	move_and_slide()
	
	
func get_portrait():
	return portrait
	
func get_text_key():
	return text_key
	
func get_client_number():
	return client_number
	
func get_dialogue_number():
	return dialogue_number
	
func get_object_name():
	return object

func set_client_number(number):
	client_number = number

func set_table_assigned(boolean):
	table_assigned = boolean

func set_dialogue_number(number):
	dialogue_number = number
	
func set_talk_zone(boolean):
	talk_zone.set_deferred("disabled", boolean)
