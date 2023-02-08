extends CharacterBody2D
class_name CharacterQueen

@onready var texture: Sprite2D = get_node("Texture")

var jump_count: int = 0

var on_jump: bool = false
var is_attacking: bool = false

@export var jump_speed: float = -256.0

@export var move_speed: float = 128.0
@export var gravity_speed: float = 448.0
@export var max_gravity_speed: float = gravity_speed * 2

func _physics_process(delta: float) -> void:
	move_handler()
	jump_handler()
	attack_handler()
	
	move_and_slide()
	
	texture.animate(velocity)
	apply_gravity(delta)
	
	
func move_handler() -> void:
	var direction: float = get_direction()
	velocity.x = direction * move_speed
	
	
func get_direction() -> float:
	return Input.get_axis("move_left", "move_right")
	
	
func jump_handler() -> void:
	if is_on_floor() and jump_count != 0 and velocity.y != jump_speed:
		jump_count = 0
		texture.action("jump_end")
		set_physics_process(false)
		
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		texture.action("jump_start")
		set_physics_process(false)
		
		
func attack_handler() -> void:
	if (
		is_attacking or 
		not is_on_floor()
	):
		return
		
	if Input.is_action_just_pressed("attack_1"):
		is_attacking = true
		texture.action("attack_1")
		set_physics_process(false)
		
	if Input.is_action_just_pressed("attack_2"):
		is_attacking = true
		texture.action("attack_2")
		set_physics_process(false)
		
		
func kill() -> void:
	texture.action("dead")
	set_physics_process(false)
	
	
func apply_gravity(delta: float) -> void:
	velocity.y += delta * gravity_speed
	velocity.y = clamp(
		velocity.y,              #Valor atual
		jump_speed,              #Valor mínimo que ele pode ter
		max_gravity_speed        #Valor máximo que ele pode ter
	)
	
	
func apply_jump() -> void:
	set_physics_process(true)
	velocity.y = jump_speed
	jump_count += 1
