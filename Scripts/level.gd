extends Node2D
@onready var timer_client_1: Timer = $TimerClient1
@onready var timer_boss: Timer = $TimerBoss
var client_number = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Singleton.time_for_next_client and !Singleton.game_end and Singleton.game_start:
		timer_client_1.start()
		client_number +=1
		Singleton.time_for_next_client = false
	elif Singleton.game_end and !Singleton.game_start :
		timer_boss.start()
		Singleton.game_end = false
	

func _on_timer_timeout() -> void:
	Singleton.create_client(1132, 492, client_number)

func _on_timer_boss_timeout() -> void:
	Singleton.create_boss(1132, 492)
