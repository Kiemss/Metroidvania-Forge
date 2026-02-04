@icon( "res://player/states/state.svg" )
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState

#region /// 状态引用
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump : PlayerStateJump = %jump
@onready var fall : PlayerStateDrop = %fall
#endregion

func init()->void:
	pass

func enter()->void:
	pass
	
func exit()->void:
	pass
	
func handle_input( _event : InputEvent )->PlayerState:
	return next_state
	
func process( _delta: float) -> PlayerState:
	return next_state
	
func physics_process( _delta: float) -> PlayerState:
	return next_state
