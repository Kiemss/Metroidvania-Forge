class_name PlayerStateDrop extends PlayerState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func process( _delta: float) -> PlayerState:
	return next_state
	
func physics_process( _delta: float) -> PlayerState:
	if player.is_on_floor():
		player.add_debug_indicator( Color.RED )
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
 
