extends RigidBody2D

# Variables for gliding physics
@export var gravity_force: float = 100.0
@export var lift_force: float = 500.0
@export var drag: float = 0.1
@export var boost_force: float = 2500
@export var max_boost_time: float = 3
@export var boost_cooldown: float = 1

# State variables
var is_boosting: bool = false
var boost_timer: float = 0.0
var cooldown_timer: float = 0.0

func _ready():
	# Set initial velocity to simulate initial launch
	linear_velocity = Vector2(500, 0)  # Moving to the right initially

func _physics_process(delta: float):
	# Apply gravity (pulls downward)
	apply_force(Vector2(0, gravity_force))

	# Handle drag (reduces velocity over time)
	linear_velocity -= linear_velocity * drag * delta

	# Handle player input for controlling lift
	if Input.is_action_pressed("ui_up"):  # Tilting upwards
		apply_force(Vector2(0, -lift_force))

	# Handle boost input
	if Input.is_action_just_pressed("boost") and cooldown_timer <= 0:
		is_boosting = true
		boost_timer = max_boost_time

	# Handle boosting logic
	if is_boosting:
		apply_force(Vector2(boost_force, 0))  # Boost forward
		boost_timer -= delta
		if boost_timer <= 0:
			is_boosting = false
			cooldown_timer = boost_cooldown

	# Handle cooldown
	if cooldown_timer > 0:
		cooldown_timer -= delta

	# Rotate airplane slightly based on vertical movement
	rotation = linear_velocity.angle()
