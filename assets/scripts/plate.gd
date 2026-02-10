extends Area2D

@onready var slot_container: Node2D = $SlotContainer

@export var slot_scene: PackedScene = preload("uid://cpmbjav7tg2et")
@export var spacing : float = 35.0

func build_word_slots(word : String):
	# clear existing slots
	for child in slot_container.get_children():
		child.queue_free()
		
	var start_x = -(word.length() - 1) * spacing / 2.0
	
	for i in range(word.length()):
		# skip spaces
		if word[i] == " ": 
			continue
		
		var new_slot = slot_scene.instantiate()
		slot_container.add_child(new_slot)
		new_slot.position = Vector2(start_x + (i * spacing), 0)
		
		new_slot.set_meta("expected_char", word[i].to_lower())
