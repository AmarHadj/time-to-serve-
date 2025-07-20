extends Node



var client_packed = load("res://assets/Characters/Clients.tscn")
var boss_packed = load("res://assets/Characters/Boss.tscn")
var meal_served = load("res://assets/furnitures/Meal.tscn")

var activate_meal_drop = false
var waiter_has_meal = false
var in_dialogue = false
var client_is_eating = false
var client_is_finished = false
var client_need_table = true
var time_to_cook = false
var time_for_next_client = true
var wig_remove = false
var tv_time = false
var game_end = false
var game_start = false
var chef_is_here = false
var is_end = false

signal display_dialog(text_key, portraitTalking)


func create_client(positionx, positiony, client_number):
	client_packed = preload("res://assets/Characters/Clients.tscn")
	var client = client_packed.instantiate()
	client.global_position.x = positionx
	client.global_position.y = positiony
	client.set_client_number(client_number)
	client.z_index = 0
	call_deferred("add_child", client)
	
func create_meal(drop_place, meal_number):
	meal_served = preload("res://assets/furnitures/Meal.tscn")
	var meal = meal_served.instantiate()
	meal.global_position = drop_place.global_position
	meal.z_index = 2
	meal.set_meal(meal_number)
	call_deferred("add_child", meal)

func create_boss(positionx, positiony):
	boss_packed = preload("res://assets/Characters/Boss.tscn")
	var boss = boss_packed.instantiate()
	boss.global_position.x = positionx
	boss.global_position.y = positiony
	boss.set_object_name("Boss2")
	boss.z_index = 2
	call_deferred("add_child", boss)
	
