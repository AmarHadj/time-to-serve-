extends Node

var client_packed = load("res://assets/Characters/Clients.tscn")
var meal_served = load("res://assets/furnitures/Meal.tscn")
var need_meal = false
var waiter_has_meal = false
var in_dialogue = false
var client_is_eating = false

signal display_dialog(text_key, portraitTalking)


func create_client(positionx, positiony, client_number, dialogue_number):
	client_packed = preload("res://assets/Characters/Clients.tscn")
	var client = client_packed.instantiate()
	client.global_position.x = positionx
	client.global_position.y = positiony
	client.set_dialogue_number(dialogue_number)
	client.set_client_number(client_number)
	client.z_index = 2
	call_deferred("add_child", client)
	
func create_meal(drop_place, meal_number):
	meal_served = preload("res://assets/furnitures/Meal.tscn")
	var meal = meal_served.instantiate()
	meal.global_position = drop_place.global_position
	meal.z_index = 2
	meal.set_meal(meal_number)
	call_deferred("add_child", meal)
	
