extends CharacterBody2D

var client_number
var dialogue_number
var table_assigned = false
var has_eaten = false
var direction
var object = "client"
const SPEED = 300.0

var text_key
@onready var portrait: Sprite2D = $portrait
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var talk_zone: CollisionShape2D = $"interactionZone/talk zone"
@onready var eating_timer: Timer = $EatingTimer


func _ready() -> void:
	text_key = "Client"+str(client_number)
	portrait.texture = load("res://assets/art/characters/portrait/Client"+str(client_number)+"Portrait.png")
	animated_sprite_2d.play("Idle"+str(client_number))
	animated_sprite_2d.flip_h = true
	
func _process(delta: float) -> void:
	if Singleton.waiter_has_meal || Singleton.client_is_eating || Singleton.activate_meal_drop:
		disable_talk_zone(true)
	else:
		disable_talk_zone(false)

func _physics_process(delta: float) -> void:
	if table_assigned and global_position.y > 201:
		direction = -1
		velocity.y = direction * SPEED
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("Walk"+str(client_number))
		hitbox.set_deferred("disabled", true)
		talk_zone.set_deferred("disabled", true)
	
	elif !table_assigned and global_position.y < 492:
		direction = 1
		velocity.y = direction * SPEED
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("HappyWalk"+str(client_number))
		hitbox.set_deferred("disabled", true)
		talk_zone.set_deferred("disabled", true)
		Singleton.client_is_finished = true
	
	else:
		if Singleton.client_is_eating:
			animated_sprite_2d.play("Eat"+str(client_number))
		elif table_assigned :
			animated_sprite_2d.play("Idle"+str(client_number))
		elif Singleton.client_is_finished:
			self.queue_free()
		
		velocity.y = 0
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
	
func disable_talk_zone(boolean):
	talk_zone.set_deferred("disabled", boolean)

func start_eating_timer():
	eating_timer.start()
	
func _on_eating_timer_timeout() -> void:
	has_eaten = true
	table_assigned = false
	Singleton.client_is_eating = false
