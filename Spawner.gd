extends Node2D


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		var new_customer : = $Prototype.duplicate()
		$SpawnPoint.add_child(new_customer)
		
