class_name PlayerStateRun extends PlayerState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func handle_input( _event : InputEvent )->PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return next_state

func process( _delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	return next_state	
	
func physics_process( _delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	if player.is_on_floor() == false: # 这也会让下斜坡像下楼梯一样
		return fall
	return next_state
