extends Node2D
@onready var timer_client_1: Timer = $TimerClient1
@onready var timer_boss: Timer = $TimerBoss
@onready var end: Sprite2D = $End
@onready var Music: AudioStreamPlayer2D = $Music
@onready var Bell: AudioStreamPlayer2D = $Bell

var client_number = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bell.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if Singleton.time_for_next_client and !Singleton.game_end and Singleton.game_start:
		timer_client_1.start()
		client_number +=1
		Singleton.time_for_next_client = false
	elif Singleton.game_end and !Singleton.game_start :
		timer_boss.start()
		Singleton.game_end = false
	
	if Singleton.is_end:
		end.visible = true
	

func _on_timer_timeout() -> void:
	Singleton.create_client(1190, 492, client_number)
	Bell.play()

func _on_timer_boss_timeout() -> void:
	Singleton.create_boss(1190, 492)
	Bell.play()

func _on_audio_stream_player_2d_finished() -> void:
	Music.play()
