extends KinematicBody2D

signal damaged

export (int) var speed = 800


const bullet_speed = 5000
const fire_rate = 1
var fire_time = 0.0
var hp = 100

# var bullet = preload("res://src/Actors/Bullet.tscn")

var velocity = Vector2()


func get_input():
	_look_at_mouse()
	velocity = Vector2()
	if Input.is_action_pressed("fly"):
		$PlayerModel.play("fly")
		velocity = Vector2(speed, 0).rotated(rotation)
	else:
		$PlayerModel.stop()
		$PlayerModel.play("stay")
#	if Input.is_action_pressed("shoot"):
#		shoot()


func _physics_process(delta):
	_hp_check()
	$Label.text = str(hp) + "/100"
	get_input()
	velocity = move_and_slide(velocity)


func _hp_check():
	if hp <= 0:
		queue_free()
		get_tree().paused = true
		get_tree().change_scene("res://src/UI/YouDiedScreen.tscn")


func _look_at_mouse():
	look_at(get_global_mouse_position())
	$PlayerModel.rotation_degrees = 90
	$FirePoint.position = Vector2(
		$PlayerModel.position.x + 270,
		$PlayerModel.position.y
	)
	$FirePoint.rotation_degrees = 90


#func shoot():
#	if get_time() - fire_time < fire_rate:
#		return
#	fire_time = get_time()
#	var bul = bullet.instance()
#	bul.rotation_degrees = rotation_degrees + 90
#	bul.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
#	get_tree().get_root().add_child(bul)
#	bul.global_position = $FirePoint.global_position


func get_time():
	return OS.get_ticks_msec() / 1000


func _on_Area2D_body_entered(body):
	if body.is_in_group("asteroids"):
		hp -= body.hp * 0.5
		emit_signal("damaged")
