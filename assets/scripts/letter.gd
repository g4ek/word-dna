extends RigidBody2D

const SIMMER_SPEED : float = 200.0 # how fast you want the letters to move
var dragging = false
var in_pot = true

@onready var default_letter: Sprite2D = $DefaultLetter
@onready var plate: Area2D = get_tree().get_first_node_in_group("Plates")


@export var character: String = "default":
	set(value):
		character = value.to_lower() # make sure it's always lowercase
		_update_visuals()


func _update_visuals():
	var path : String = "res://assets/sprites/Letters/" + character + "_letter.png"
	
	var tex = load(path)
	default_letter.texture = tex

func apply_simmer():
	var random_dir = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()
	
	apply_central_force(random_dir * SIMMER_SPEED)

func is_mouse_over() -> bool:
	var mouse_pos = get_global_mouse_position()
	var dist = global_position.distance_to(mouse_pos)
	return dist <= 30.0

func check_snap() -> void:
	var closest_slot = null
	var shortest_dist = 80.0
	
	for slot in plate.get_node("SlotContainer").get_children():
		var dist = global_position.distance_to(slot.global_position)
		if dist < shortest_dist:
			shortest_dist = dist
			closest_slot = slot
	
	if closest_slot:
		global_position = closest_slot.global_position
		freeze = true
		
		if closest_slot.get_meta("expected_char") == self.character:
			print("Correct Letter!")
		else:
			print("Incorrect! Try again.")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_visuals() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position()
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			dragging = false
			freeze = false # turns on physics
			check_snap()
			
	else:
		if is_mouse_over() and Input.is_action_just_pressed("select"):
			dragging = true
			freeze = true
			
	
	if in_pot:
		apply_simmer()
