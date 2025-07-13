extends Node

var client_packed = load("res://assets/Characters/Clients.tscn")

signal display_dialog(text_key, portraitTalking)

func create_client(positionx, positiony, rotation, speedx, speedy, client_number):
		client_packed = preload("res://assets/Characters/Clients.tscn")
		var client = client_packed.instantiate()
		client.global_position.x = positionx
		client.global_position.y = positiony
		client.set_rotation_degrees(rotation)
		client.set_client_number(client_number)
		client.z_index = 2
		call_deferred("add_child", client)
