extends Sprite2D
class_name CharacterTexture

var on_jump: bool = false
var on_action: bool = false

var first_attack_position: Vector2 = Vector2(12.5, -14)
var second_attack_position: Vector2 = Vector2(-1.5, 3.5)

@export var animation: AnimationPlayer = null
@export var character: CharacterBody2D = null
@export var attak_area_collision: CollisionShape2D = null

func animate(velocity: Vector2) -> void:
	set_direction(velocity.x)
	
	if on_action:
		return
		
	if velocity.y != 0:
		vertical_behavior()
		return
		
	if velocity.y == 0 and on_jump:
		animation.play("jump_end")
		character.set_physics_process(false)
		return
		
	horizontal_behavior(velocity.x)
	
	
func set_direction(direction: float) -> void:
	if direction > 0:
		flip_h = false
		first_attack_position.x = abs(first_attack_position.x)
		second_attack_position.x = abs(second_attack_position.x)
		
	if direction < 0:
		flip_h = true
		first_attack_position.x = -abs(first_attack_position.x)
		second_attack_position.x = -abs(second_attack_position.x)
		
		
func action(anim: String) -> void:
	on_action = true
	
	if anim == "attack_1":
		attak_area_collision.position = first_attack_position
		
	if anim == "attack_2":
		attak_area_collision.position = second_attack_position
		
	animation.play(anim)
	
	
func vertical_behavior() -> void:
	if animation.current_animation == "":
		return
		
	if animation.current_animation != "jump":
		animation.play("jump")
		on_jump = true
		
		
func horizontal_behavior(vel: float) -> void:
	if vel != 0:
		animation.play("run")
		return
		
	animation.play("idle")
	
	
func change_offset(anim_name: String) -> void:
	var new_offset: Vector2 = Vector2.ZERO
	
	match anim_name:
		"jump":
			new_offset = Vector2(-4, -8)
			
		"jump_start":
			new_offset = Vector2(4, -8)
			
		"jump_end":
			new_offset = Vector2(4, -8)
			
		"dead":
			new_offset = Vector2(10, 8)
			
	if flip_h:
		new_offset.x *= -1
		
	offset = new_offset
	
	
func on_animation_finished(anim_name) -> void:
	if anim_name == "jump_start":
		animation.play("jump")
		
	if anim_name == "jump_end":
		on_jump = false
		on_action = false
		character.set_physics_process(true)
		
	if anim_name == "attack_1" or anim_name == "attack_2":
		on_action = false
		character.is_attacking = false
		character.set_physics_process(true)
