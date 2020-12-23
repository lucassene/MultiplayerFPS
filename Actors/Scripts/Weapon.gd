extends Spatial

onready var anim_player = $AnimationPlayer

export var AUTO = false
export var RATE_OF_FIRE = 1.0
export var MAGAZINE = 10
export var DAMAGE = 5 setget ,get_damage

export var ADS_POSITION = Vector3.ZERO setget ,get_ads_position
export var ADS_SPEED = 20 setget ,get_ads_speed
export var ADS_FOV = 50 setget ,get_ads_fov
export var SWAY = 40
export var ADS_SWAY = 100
export var SPRINT_ANGLE = 45 setget ,get_sprint_angle
export var X_RECOIL = 0.1
export var Y_RECOIL = 0.5

var is_ads = false
var current_magazine
var can_fire = true setget ,get_can_fire

func get_default_position():
	return Vector3.ZERO

func get_ads_position():
	return ADS_POSITION

func get_ads_speed():
	return ADS_SPEED

func get_ads_fov():
	return ADS_FOV

func get_sway():
	return SWAY if !is_ads else ADS_SWAY

func get_sprint_angle():
	return SPRINT_ANGLE

func get_damage():
	return DAMAGE

func get_can_fire():
	return can_fire

func _ready():
	anim_player.playback_speed *= RATE_OF_FIRE
	transform.origin = Vector3.ZERO
	current_magazine = MAGAZINE

func _process(delta):
	if is_ads:
		transform.origin = transform.origin.linear_interpolate(ADS_POSITION,ADS_SPEED * delta)
	else:
		transform.origin = transform.origin.linear_interpolate(Vector3.ZERO,ADS_SPEED * delta)
		
func ads(value):
	is_ads = value

func update():
	pass
	
func fire(value,target = null):
	if value:
		anim_player.play("firing")
		current_magazine -= 1
		can_fire = false
		if target and target.is_in_group("Enemy"):
			target.add_damage(DAMAGE)
	else:
		if AUTO: anim_player.stop()

func reload():
	if current_magazine < MAGAZINE:
		current_magazine = MAGAZINE
	can_fire = true

func _on_AnimationPlayer_animation_finished(_anim_name):
	if current_magazine > 0:
		if AUTO:
			anim_player.play("firing")
			Global.player.get_aimcast_collider()
		can_fire = true
	#Global.player.camera_reset()

func _on_AnimationPlayer_animation_started(_anim_name):
	Global.player.shake_camera(X_RECOIL,Y_RECOIL)
