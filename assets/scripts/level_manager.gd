extends Node

# put all your levels here in the inspector
@export var levels : Array 
var level
var num_level : int = 0

@onready var main_menu: Control = $MainMenu
@onready var level_selection: Control = $LevelSelection


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu.open_level_selection.connect(_on_open_level_selection)
	level_selection.level_selected.connect(_on_level_selected)
	
	
	main_menu.show()
	level_selection.hide()

func _on_open_level_selection():
	main_menu.hide()
	level_selection.show()
	
func _on_level_selected(index : int):
	level_selection.hide()
	num_level = index
	
	if level != null:
		level.queue_free()
	
	load_level(num_level)
	
func _on_menu_selected() -> void:
	if level != null:
		level.queue_free()
		level = null
	
	main_menu.show()
	level_selection.hide()

func _on_next_level() -> void:
	num_level += 1
	
	if level != null:
		level.queue_free()
		level = null
	
	if num_level >= levels.size():
		main_menu.show()
		level_selection.hide()
		num_level = 0
		return
	
	load_level(num_level)

func load_level(index : int):
	level = levels[index].instantiate()
	self.add_child(level)
	
	level.go_to_menu.connect(_on_menu_selected)
	level.next_level.connect(_on_next_level)
