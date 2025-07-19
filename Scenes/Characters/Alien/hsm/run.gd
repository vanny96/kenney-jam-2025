extends LimboState

@export var animation_player: AnimationPlayer
@export var alien: Alien

func _enter() -> void:
	animation_player.play("alien/run")

func _update(delta: float) -> void:
	var closest_citizien: Node3D = find_closest()
	var distance := closest_citizien.global_position - alien.global_position
	alien.look_at(alien.global_position - distance)
	if distance.length() < alien.attack_distance:
		dispatch(AlienHSM.transition_attack)
	else:
		var direction := distance.normalized()
		alien.velocity = direction * alien.speed
		if not alien.is_on_floor():
			alien.velocity.y = -9.8
		alien.move_and_slide()

func find_closest() -> Node3D:
	var citiziens = get_tree().get_nodes_in_group("citizien")
	var closest: Node3D
	var closest_distance: float
	for citizien: Node3D in get_tree().get_nodes_in_group("citizien"):
		var distance = (citizien.global_position - alien.global_position).length()
		if citizien is Heroine:
			distance -= 1
		if not closest_distance or distance < closest_distance:
			closest_distance = distance
			closest = citizien
	return closest
