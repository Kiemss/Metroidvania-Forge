class_name PlayerStateIdle extends PlayerState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter()->void:
	pass

func handle_input( _event : InputEvent )->PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return next_state

func process( _delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	return next_state
	
func physics_process( _delta: float) -> PlayerState:
	player.velocity.x = 0
	if player.is_on_floor() == false:
		return fall
	return next_state
 
