extends RigidBody2D


@export var speed = 300
var start_velocity = Vector2(1, -1) * speed
var velocity = start_velocity
var initial_position = Vector2(170, 650)
var is_resetting = false


signal ball_exited


func freeze() -> void:
	velocity = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze()
	gravity_scale = 0


func reset() -> void:
	position = Vector2(170, 650)
	freeze()


func start() -> void:
	velocity = start_velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		var collider = collision.get_collider()
		if collider.is_in_group('bricks'):
			collider.destroy()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if is_resetting:
		state.transform.origin = initial_position
		# Call reset_physics_interpolation() at the end of the frame once the physics engine has been updated
		reset_physics_interpolation.call_deferred()
		is_resetting = false


func _on_ball_exited() -> void:
	ball_exited.emit()
	is_resetting = true
