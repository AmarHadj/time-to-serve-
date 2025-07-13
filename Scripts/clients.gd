extends CharacterBody2D

var is_in_waiter_range = false
var client_number

var text_key
@onready var portrait: Sprite2D = $portrait
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_interaction_zone_area_entered(area: Area2D) -> void:
	is_in_waiter_range = true

func _on_interaction_zone_area_exited(area: Area2D) -> void:
	is_in_waiter_range = false
	
func get_portrait():
	return portrait
	
func get_text_key():
	return text_key
	
func get_client_number():
	return client_number

func set_client_number(number):
	client_number = number


func _ready() -> void:
	text_key = "client"+str(client_number)
	portrait.texture = load("res://assets/art/characters/portrait/Client"+str(client_number)+"Portrait.png")
	animated_sprite_2d.play("Idle"+str(client_number))

func _process(delta: float) -> void:
	pass
