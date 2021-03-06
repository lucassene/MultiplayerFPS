extends State

export var CAN_STOW = false

func enter(_delta = 0.0):
	print(actor.name + " OUT OF AMMO")
	controller.play_animation(controller.OUT_OF_AMMO)

func handle_input(event):
	if controller.check_input_pressed(event,"aim","aim",true): return
	if controller.check_input_released(event,"aim","aim",false): return

func update(delta):
	if controller.is_ads() and actor.transform.origin != actor.ADS_POSITION:
		actor.transform.origin = actor.transform.origin.linear_interpolate(actor.ADS_POSITION,actor.ADS_SPEED * delta)
	elif actor.transform.origin != actor.DEFAULT_POSITION:
		actor.transform.origin = actor.transform.origin.linear_interpolate(actor.DEFAULT_POSITION,actor.ADS_SPEED * delta)

