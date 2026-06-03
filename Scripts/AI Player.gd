extends KinematicBody2D

var movement = Vector2()
const speed = 30
const up = Vector2.UP
var grav = 10
const gravitycount = 10
const jump = 600
const stomp = 7
var able = true
var jumpable = true
var bullet = preload("res://Scences/Asset Scences/bullet1.tscn")
var bullet2 = preload("res://Scences/Asset Scences/bullet2.tscn")
var rounds = 1
const movesp = 0.01
var want = true
export var storage = {
			"health": 100, 
			"scorelost": 0
}



func _on_UpHealthArea2D_area_entered(area):
	if area.name == "JumpArea2D":
		storage["health"] -= stomp
		reset()


func _process(delta):
	if storage["scorelost"] >= rounds:
		get_parent().get_node("Player2Loss").show()
		get_parent().get_node("Lights").hide()
		get_parent().get_node("Overlay").hide()
		get_parent().get_node("Player2").hide()
		get_parent().get_node("Player1").hide()
		get_parent().get_node("Player1Loss").hide()
		get_parent().get_node("CanvasModulate").hide()
		storage["scorelost"] = 0
		storage["health"] = 0
	get_parent().get_node("Overlay/Score1").text = "kill : " + str(storage["scorelost"])
	get_parent().get_node("Overlay/Health 2").value = storage["health"]
	if storage["health"] <= 0:
		
		reset()
		storage["scorelost"] += 1
		storage["health"] = 100




func reset():
	self.position = get_parent().get_node("Spawn2").position


func shoot():
	if able == true:
		$CloneTimer.start()
		able = false
		var instance = bullet.instance()
		var instance2 = bullet2.instance()
		get_parent().add_child(instance)
		get_parent().add_child(instance2)
		instance.global_position = $pos.global_position
		instance2.global_position = $pos2.global_position


func _on_CloneTimer_timeout():
	able = true


func _physics_process(delta):
	var destination = get_parent().get_node("Player1").global_position
	var path = get_parent().get_node("Navigation2D").get_simple_path(self.position, destination)
	if get_parent().get_node("Player1").global_position.y > global_position.y:
		grav = 10
	else:
		grav = - 10
	movement.y += grav
	move_and_slide(movement * 10, up)
	if path.size() > 0:
		position = position.linear_interpolate(path[1], movesp)
	jump(jump)
	shoot()
	
	
func jump(value):
	if jumpable == true and is_on_floor():
		$JumpSound.play()
		$JumpTimer.start()
		jumpable = false
		$Sprite.frame = 1
		movement.y -= value


func _on_JumpTimer_timeout():
	jumpable = true


func _on_JumpArea2D_area_entered(area):
	pass


func _on_Collider_body_entered(body):
	pass


func _on_Main_Area2D_area_entered(area):
	$ShootSound.play()
