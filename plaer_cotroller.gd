extends CharacterBody2D
class_name Character
var _state_machine
var _synced_velocity: Vector2 = Vector2.ZERO

@onready var camera = $Camera2D as Camera2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _enter_tree():
	set_multiplayer_authority(name.to_int())


#func _ready() -> void:
	#_state_machine = _animation_tree["parameters/playback"]
	#if is_multiplayer_authority(): camera.make_current()
#
#func _physics_process(delta: float) -> void:
	#if is_multiplayer_authority():
		#_move()
		#move_and_slide()
	#else:
		#velocity = _synced_velocity
	#_animate()
	#
	#
#func _move() -> void:
	#var _direction: Vector2 = Vector2(
		#Input.get_axis("move_left", "move_right"),
		#Input.get_axis("move_up", "move_down")
	#)
#
	#if _direction != Vector2.ZERO:
		#if is_multiplayer_authority():
			#rpc("sync_movement", _direction, _move_speed)
		#_update_animation_direction(_direction)
		#velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		#velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
	#else:
		#if is_multiplayer_authority():
			#rpc("sync_movement", Vector2.ZERO, 0.0)
		#_update_animation_direction(Vector2.ZERO)
		#velocity.x = lerp(velocity.x, 0.0, _friction)
		#velocity.y = lerp(velocity.y, 0.0, _friction)
#
#func _update_animation_direction(new_direction: Vector2) -> void:
	#_animation_tree["parameters/idle/blend_position"] = new_direction
	#_animation_tree["parameters/walk/blend_position"] = new_direction
	#_animate()
#
#func _animate() -> void:
	#if velocity.length() > 10:
		#_state_machine.travel("walk")
	#else:
		#_state_machine.travel("idle")
#
#@rpc func sync_movement(new_direction: Vector2, speed: float) -> void:
	#_synced_velocity = new_direction.normalized() * speed
	#_update_animation_direction(new_direction)
	#_animate()
	
	
	
func _ready() -> void:
	if is_multiplayer_authority(): camera.make_current()
	
func _physics_process(delta: float) -> void:
	
	 #Add the gravity.
	if not is_on_floor():
			velocity += get_gravity() * delta

	if is_multiplayer_authority():
	# Handle jump.
		if Input.is_action_just_pressed("jump"): # and is_on_floor():
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
		
	move_and_slide()
	
