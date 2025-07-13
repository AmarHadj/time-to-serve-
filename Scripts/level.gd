extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	Singleton.create_client(1114, 543, 0, 0, 0, 1)


func _on_timer_client_2_timeout() -> void:
	Singleton.create_client(1114, 200, 0, 0, 0, 2)
