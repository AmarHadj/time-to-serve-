#code from StevePixelFace
extends CanvasLayer

@export_file("*json") var scene_text_file: String

var scene_text: Dictionary = {}
var selected_text: Array = []
var in_progress: bool = false

@onready var portrait: Sprite2D = $portrait
@onready var background = $Background
@onready var text_label = $TextLabel

func _ready():
	background.visible = false
	scene_text = load_scene_text()
	Singleton.connect("display_dialog", Callable(self, "on_display_dialog"))

func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		var file = FileAccess.open(scene_text_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()

func show_text():
	text_label.text = selected_text.pop_front()
	Singleton.in_dialogue = true

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	text_label.text = ""
	background.visible = false
	portrait.texture = null
	in_progress = false
	get_tree().paused = false
	Singleton.in_dialogue = false
	
func on_display_dialog(text_key, portraitTalking):
	if in_progress:
		portrait.texture = portraitTalking.texture
		next_line()
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		portrait.texture = portraitTalking.texture
		selected_text = scene_text[text_key].duplicate()
		show_text()
