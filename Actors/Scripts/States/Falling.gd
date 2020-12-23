extends "res://Utils/scripts/State.gd"

var player_controller

func enter(actor,_delta = 0.0):
	player_controller = actor.get_player_controller()
	actor.play_camera_anim(false)
	print("Falling")

func handle_input(event):
	if player_controller.check_input_pressed(event,"fire","fire"): return
	if player_controller.check_input_pressed(event,"aim","aim",true): return
	if player_controller.check_input_released(event,"aim","aim",false): return

func update(actor,delta):
	if !actor.is_on_floor():
		player_controller.actor_in_air(delta)
	else:
		state_machine.set_state("Idle")
		return
	actor.move(delta)
