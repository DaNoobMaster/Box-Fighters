extends KinematicBody2D
var movement = Vector2()
const speed = 30
const up = Vector2.UP
var grav = 10
const gravitycount = 10
const jump = 600
const stomp = 7
var rounds = global.rounds
var able = true
var bullet = preload("res://Scences/Asset Scences/bullet2.tscn")
var bullet2 = preload("res://Scences/Asset Scences/bullet1.tscn")
export var storage = {
			"health": 100, 
			"scorelost": 0
}






func _physics_process(delta):
	movement.y += grav
	if Input.is_action_pressed("left2") and Input.is_action_pressed("right2") or Input.is_action_pressed("up2") or Input.is_action_pressed("down2"):
		movement.x = lerp(movement.x, 0, 0.1)
		movement.y = lerp(movement.y, 0, 0.1)
	if Input.is_action_pressed("left2"):
		movement.x = - speed
		$Sprite.frame = 3
	if Input.is_action_pressed("right2"):
		movement.x = speed
		$Sprite.frame = 2
	else:
		movement.x = lerp(movement.x, 0, 0.1)
		movement.y = lerp(movement.y, 0, 0.1)
		
		
	if Input.is_action_pressed("down2"):
		if is_on_floor():
			grav = gravitycount
		else:
			grav *= 1.5
			
	if Input.is_action_just_pressed("up2"):
		if is_on_floor():
			$JumpSound.play()
			$Sprite.frame = 0
			$Sprite.frame = 1
			movement.y -= jump
			
	
	if Input.is_action_just_pressed("shoot2"):
		shoot()
	
	
	
	
	move_and_slide(movement * 10, up)


func _on_UpHealthArea2D_area_entered(area):
	if area.name == "JumpArea2D":
		storage["health"] -= stomp


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


func _on_Main_Area2_area_entered(area):
	$ShootSound.play()
