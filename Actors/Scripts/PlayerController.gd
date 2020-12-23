extends Node

onready var actor = owner

export var GRAVITY = 20
export var JUMP_IMPULSE = 10

var state_machine
var mouse_sensitivity = 0.05
var current_speed = 0.0 setget set_current_speed,get_current_speed
var current_acceleration = 0.0 setget set_current_acceleration

var h_velocity = Vector3.ZERO
var movement = Vector3.ZERO setget ,get_movement
var gravity_vector = Vector3.ZERO

func set_current_speed(value):
	current_speed = value

func get_current_speed():
	return current_speed

func set_current_acceleration(value):
	current_acceleration = value

func get_movement():
	return movement

func _initialize(fsm):
	state_machine = fsm
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func handle_input(event):
	handle_mouse_movement(event)

func check_input_pressed(event,input,method = null,param = null):
	if event.is_action_pressed(input):
		if method: call_deferred(method,param)
		return true
	return false

func check_input_released(event,input,method = null,param = null):
	if event.is_action_released(input):
		if method: call_deferred(method,param)
		return true
	return false

func handle_mouse_movement(event):
	if event is InputEventMouseMotion:
		actor.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		actor.head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		actor.head.rotation.x = clamp(actor.head.rotation.x,deg2rad(-58),deg2rad(80))

func calculate_movement(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		direction -= actor.transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += actor.transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= actor.transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction += actor.transform.basis.x
	
	direction = direction.normalized()
	h_velocity = h_velocity.linear_interpolate(direction * current_speed, current_acceleration * delta)
	movement.z = h_velocity.z + gravity_vector.z
	movement.x = h_velocity.x + gravity_vector.x
	movement.y = gravity_vector.y
	
	return movement

func actor_on_floor():
	if actor.is_on_floor() and actor.get_floor_contact():
		gravity_vector = -actor.get_floor_normal() * GRAVITY
	else:
		state_machine.set_state("Falling")
		gravity_vector = -actor.get_floor_normal()

func jump(_param):
	if actor.is_on_floor() or actor.get_floor_contact():
		state_machine.set_state("Jumping")
		gravity_vector = Vector3.UP * JUMP_IMPULSE

func fire(_param):
	actor.get_aimcast_collider()

func stop_firing(_param):
	actor.stop_firing()

func aim(param):
	if param and actor.get_is_moving(): state_machine.set_state("Running")
	actor.ads(param)

func sprint(param):
	if param:
		state_machine.set_state("Sprinting")
	else:
		state_machine.set_state("Idle")

func reload(_param):
	actor.reload_weapon()

func equip_slot_1(_param):
	actor.equip_slot(0)

func equip_slot_2(_param):
	actor.equip_slot(1)

func swap_equip(_param):
	actor.swap_equip()

func actor_in_air(delta):
	gravity_vector += Vector3.DOWN * GRAVITY * delta
	return movement
