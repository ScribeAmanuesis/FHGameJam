extends CharacterBody2D

@export var seats_node : Node2D
@export var pathfinding : Node2D
@export var friction : = 0.1

@onready var astar : AStar2D = pathfinding.astar

const SPEED = 20.0
var seat_pos : = Vector2.ZERO
var path : = []
var path_tolerance : = 16.0

var order_choices : = [
	"PIZZA",
	"OTHER"
]
var order_modifiers : = [
	"Block Text",
	"Lengthy Pleasantries",
	"Math numbers"
]

var eating_time : = Vector2(1.0, 4.0)
var current_eating_time : = randf_range(eating_time.x, eating_time.y)

func _ready():
	#Pick a seat
	var seats_list : = seats_node.get_children()
	seats_list.shuffle()
	seat_pos = seats_list[0].global_position
	find_path_to(seat_pos)

func _process(delta):
	if path:
		var direction : = global_position.direction_to(path[0])
	
		velocity += SPEED * direction
	
		if global_position.distance_to(path[0]) < path_tolerance:
			path.pop_front()
	
	if global_position.distance_to(seat_pos) < path_tolerance:
		current_eating_time -= delta
		if current_eating_time <= 0.0:
			find_path_to(get_global_mouse_position())
			current_eating_time = randf_range(eating_time.x, eating_time.y)
	velocity *= (1.0 - friction)
	move_and_slide()
	
func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		find_path_to(get_global_mouse_position())
	
func find_path_to(pos : Vector2):
	path = astar.get_point_path(
		astar.get_closest_point(global_position),
		astar.get_closest_point(pos)
	)
