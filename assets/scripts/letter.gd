extends RigidBody2D

const SIMMER_SPEED : float = 200.0 # how fast you want the letters to move

@onready var default_letter: Sprite2D = $DefaultLetter

@export var character: String = "a":
	set(value):
		character = value.to_lower() # make sure it's always uppercase
		_update_visuals()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_visuals() # Replace with function body.

func _update_visuals():
	var path : String = "res://assets/sprites/Letters/" + character + "_letter.png"
	
	var tex = load(path)
	default_letter.texture = tex

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# create a random directioon
	var random_dir = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()
	
	apply_central_force(random_dir * SIMMER_SPEED)
