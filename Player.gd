extends CharacterBody2D


const SPEED = 100.0
@export var friction : = 0.1


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	
	velocity += SPEED * direction
		
	velocity *= (1.0 - friction)

	move_and_slide()
