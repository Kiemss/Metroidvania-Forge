class_name PlayerStateJump extends PlayerState

@export var jump_velocity : float = 450.0

func enter()->void:
	player.add_debug_indicator( Color.LIME_GREEN )
	player.velocity.y = -jump_velocity

func exit()->void:
	player.add_debug_indicator( Color.YELLOW )

func handle_input( event : InputEvent )->PlayerState:
	if event.is_action_released("jump"):
		player.velocity *= 0.5
		return fall #这里立即return fall，逻辑和等待velocity == 0时自动进入fall是不一样的
	return next_state

func process( _delta: float) -> PlayerState:
	return next_state
	
func physics_process( _delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
