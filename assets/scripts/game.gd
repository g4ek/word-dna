extends Node2D

@onready var soup_pot: StaticBody2D = $SoupPot
@onready var plate: Area2D = $Plate


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_level("game") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_level(target_word : String):
	plate.build_word_slots(target_word)
	soup_pot.gen_letters_from_word(target_word)
