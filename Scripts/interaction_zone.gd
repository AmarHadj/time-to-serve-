extends Area2D

@onready var portrait: Sprite2D = $"../portrait"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var object_touched = null
var meal_served
var client_number
var client_served
var Strtable
var chef_portrait
var meal_drop
var discussion_progress_client = 0
var discussion_progress_chef = 0
var discussion_progress_boss = 0

func _on_area_entered(area: Area2D) -> void:
	object_touched = area.get_parent()

func _on_area_exited(_area: Area2D) -> void:
	object_touched = null

func _input(event):
	if object_touched and event.is_action_pressed("ui_accept"):
		if object_touched.get_object_name() == "Boss" and !Singleton.game_start:
			print("boss touche")
			if discussion_progress_boss % 2 == 0: 
				Singleton.emit_signal("display_dialog", object_touched.get_text_key()+"Start", portrait)
			elif discussion_progress_boss % 2 == 1:
				Singleton.emit_signal("display_dialog", object_touched.get_text_key()+"Start", object_touched.get_portrait())
			discussion_progress_boss += 1
			if !Singleton.in_dialogue:
				Singleton.game_start = true
		
		
		if object_touched.get_object_name() == "Boss2" and !Singleton.game_start:
			print("boss2 touche")
			if discussion_progress_boss % 2 == 0: 
				Singleton.emit_signal("display_dialog", object_touched.get_text_key()+"Fin", portrait)
			elif discussion_progress_boss % 2 == 1:
				Singleton.emit_signal("display_dialog", object_touched.get_text_key()+"Fin", object_touched.get_portrait())
			discussion_progress_boss += 1
			if !Singleton.in_dialogue:
				Singleton.is_end = true 
				collision_shape_2d.set_deferred("disabled", true)
			
		elif object_touched.get_object_name() == "client" and !Singleton.activate_meal_drop:
			print("client touche")
			if discussion_progress_client != object_touched.get_dialogue_number() + 1:
				if Singleton.client_need_table:
					Strtable = "table"
				else:
					Strtable = ""
				if discussion_progress_client % 2 == 0: 
					Singleton.emit_signal("display_dialog", Strtable + object_touched.get_text_key(), portrait)
				elif discussion_progress_client % 2 == 1:
					Singleton.emit_signal("display_dialog", Strtable + object_touched.get_text_key(), object_touched.get_portrait())
				discussion_progress_client += 1
				#the client moves to his table
				if discussion_progress_client == 5 and Singleton.client_need_table:
					Singleton.client_need_table = false
					object_touched.set_table_assigned(true)
					discussion_progress_client = 0
				#The order is taken
				if discussion_progress_client > object_touched.get_dialogue_number():
					client_number = object_touched.get_client_number()
					client_served = object_touched
					client_served.set_is_waiting(true)
					Singleton.activate_meal_drop = true
					
		elif object_touched.get_object_name() == "meal_drop" and Singleton.activate_meal_drop:
			print("meal drop touche")
			meal_drop = object_touched
			
			if !Singleton.waiter_has_meal and !Singleton.game_end:
				chef_portrait = meal_drop.get_portrait()
				if discussion_progress_chef % 2 == 0: 
					Singleton.emit_signal("display_dialog", "ChefCook"+str(client_number), portrait)
				elif discussion_progress_chef % 2 == 1:
					Singleton.emit_signal("display_dialog", "ChefCook"+str(client_number), chef_portrait)
				discussion_progress_chef += 1
				if !Singleton.in_dialogue and client_number == 3:
					Singleton.tv_time = true
					Singleton.activate_meal_drop = false
					
			elif Singleton.game_end and Singleton.chef_is_here:
				chef_portrait = meal_drop.get_portrait()
				if discussion_progress_chef % 2 == 0: 
					Singleton.emit_signal("display_dialog", "FinChef", portrait)
				elif discussion_progress_chef % 2 == 1:
					Singleton.emit_signal("display_dialog", "FinChef", chef_portrait)
				discussion_progress_chef += 1
				if !Singleton.in_dialogue and client_number == 3:
					Singleton.activate_meal_drop = false
					Singleton.game_start = false

			if !Singleton.waiter_has_meal and !Singleton.in_dialogue and client_number != 3:
				object_touched.prepare_meal(client_number)
				Singleton.activate_meal_drop = false
			
			elif Singleton.waiter_has_meal and Singleton.client_is_finished and !Singleton.in_dialogue:
				self.get_parent().let_go_of_meal()
				Singleton.client_is_finished = false
				Singleton.waiter_has_meal = false
				Singleton.time_for_next_client = true
				Singleton.tv_time = false
				discussion_progress_client = 0
				discussion_progress_chef = 0
				if client_number != 3:
					Singleton.activate_meal_drop = false
				if client_number == 3:
					Singleton.game_end = true
			
		elif object_touched.get_object_name() == "meal":
			print("meal touche")
			
			if client_number == 2 and !Singleton.waiter_has_meal and !Singleton.client_is_finished:
				chef_portrait = meal_drop.get_portrait()
				if discussion_progress_chef % 2 == 0: 
					Singleton.emit_signal("display_dialog", "Wig", portrait)
				elif discussion_progress_chef % 2 == 1:
					Singleton.emit_signal("display_dialog", "Wig", chef_portrait)
				discussion_progress_chef += 1
				
			if Singleton.client_is_finished and client_number == 1 :
				Singleton.emit_signal("display_dialog", Strtable + "finishedClient1", portrait)
			
			if !Singleton.in_dialogue and Singleton.client_is_finished:
				self.get_parent().set_meal_to_serve(object_touched)
				Singleton.waiter_has_meal = true
				Singleton.activate_meal_drop = true
				if client_number != 1:
					object_touched.set_money(false)

				
			elif !Singleton.in_dialogue:
				self.get_parent().set_meal_to_serve(object_touched)
				Singleton.waiter_has_meal = true
				
				


		elif object_touched.get_object_name() == "table" and Singleton.waiter_has_meal and !Singleton.client_is_finished:
			print("table touche")
			if !Singleton.client_is_finished:
				self.get_parent().put_meal_on_table(object_touched)
				client_served.start_eating_timer()
		else:
			print(object_touched)
				
