extends Node2D
@onready var timer_client_1: Timer = $TimerClient1
var client_number = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Singleton.time_for_next_client:
		timer_client_1.start()
		client_number +=1
		Singleton.time_for_next_client = false
	


func _on_timer_timeout() -> void:
	Singleton.create_client(1132, 492, client_number)


#func _on_timer_client_2_timeout() -> void:
	#Singleton.create_client(1114, 200, 0, 0, 0, 2)
