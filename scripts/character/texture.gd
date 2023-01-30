extends Sprite2D
class_name CharacterTexture

var on_action: bool = false

@export var animation: AnimationPlayer = null
@export var character: CharacterBody2D = null

func animate(velocity: Vector2) -> void:
	set_direction(velocity.x)
	
	if on_action:
		return
		
	horizontal_behavior(velocity.x)
	
	
func set_direction(direction: float) -> void:
	if direction > 0:
		flip_h = false
		
	if direction < 0:
		flip_h = true
		
		
func action(anim: String) -> void:
	on_action = true
	animation.play(anim)
	
	
func horizontal_behavior(x_vel: float) -> void:
	if x_vel != 0:
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
			
	if flip_h:
		new_offset.x *= -1
		
	offset = new_offset
	
	
func on_animation_finished(anim_name) -> void:
	if anim_name == "jump_start":
		animation.play("jump")
		
	if anim_name == "jump_end":
		on_action = false
		character.set_physics_process(true)
