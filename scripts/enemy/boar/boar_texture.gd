extends Sprite2D

const PNG: String = ".png"

var walk_path: String = "res://assets/mob/boar/walk/"
var idle_path: String = "res://assets/mob/boar/idle/"
var hit_path: String = "res://assets/mob/boar/hit/"
var run_path: String = "res://assets/mob/boar/run/"

var texture_index: int = -1

@export var texture_amount: int = -1
@export var animation: AnimationPlayer = null

func _ready() -> void:
	randomize()
	set_skin()
	
	
func set_skin() -> void:
	animation.play("idle")
	texture_index = randi() % texture_amount + 1
	texture = load(idle_path + str(texture_index) + PNG)
