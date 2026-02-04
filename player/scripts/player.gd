class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICATOR = preload("uid://1n5lkptfbcul")


#region /// 导出变量
@export var move_speed : float = 150
#endregion

#region /// 状态机变量
var states : Array[ PlayerState ]
# getter语法：保证current_state被调用时永远指向states数组的第一个元素
var current_state : PlayerState : 
	get : return states.front()
var previous_state : PlayerState : 
	get : return states[1]
#endregion

#region /// 标准状态变量
var direction : Vector2 = Vector2(0,0)
var gravity : float = 980
#endregion

func _ready() -> void:
	# 初始化状态
	initialize_state()
	pass

# change_state()的嵌套调用：process()等函数会返回一个新的state，将其传入change_state()中
func _unhandled_input(event: InputEvent) -> void:
	change_state( current_state.handle_input( event ) )
	pass

func _process(_delta: float) -> void:
	update_direction()
	change_state( current_state.process( _delta ) )
	pass

func _physics_process(_delta: float) -> void:
	velocity.y += gravity * _delta
	move_and_slide()
	change_state( current_state.physics_process( _delta ) )
	pass
	
func initialize_state() -> void:
	states = []
	for c in $State.get_children():
		if c is PlayerState:
			c.player = self
			states.append(c)
	
	# 如果列表为空，直接返回		
	if states.size() == 0 :
		return
	
	for state in states : 
		state.init()
	
	change_state(current_state)
	$Label.text = current_state.name #这是必要的，否则初始化后不更新状态
		
func change_state( new_state : PlayerState ) -> void:
	if new_state == null : 
		return
	elif new_state == current_state:
		return
		
	# 确保当前状态存在（初始化时当前状态是不存在的）才能调用exit()函数
	if current_state:
		current_state.exit()
		
	states.push_front( new_state )
	current_state.enter()
	states.resize(3) #保证状态列表的长度恒定，不追踪多余的历史状态
	
	$Label.text = current_state.name
	pass
	
func update_direction() -> void:
	var pre_direction : Vector2 = direction
	# direction = Input.get_vector("left", "right", "up", "down") #应该在不使用摇杆控制时采取这行代码
	# 优化方案：分两个方向使用代码
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	# print(y_axis)
	direction = Vector2(x_axis, y_axis)
	pass
	
func add_debug_indicator(color : Color = Color.RED) -> void : 
	var d : Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child( d )
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer( 3.0 ).timeout
	''' 上面那行是链式调用，原格式如下
	var timer = get_tree().create_timer(3.0)  # 1. 创建计时器
	await timer.timeout                      # 2. 等待它的 timeout 信号
	'''
	d.queue_free()
	pass
