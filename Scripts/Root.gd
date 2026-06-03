extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://Scences/Menu.tscn")
	$Overlay / FPSLabel.text = "fps : " + str(Engine.get_frames_per_second())
		
func _ready():
	$Player1Loss.hide()
	$Player2Loss.hide()
	$Player1.position = $Spawn1.position
	$Player2.position = $Spawn2.position





func _on_OkButton_pressed():
	$Player1.storage["health"] = 0
	$Player2.storage["health"] = 0
	$Player2.storage["scorelost"] = 0
	$Player1.storage["scorelost"] = 0
	$Player1Loss.hide()
	$Player2Loss.hide()
	get_tree().change_scene("res://Scences/Main Menu.tscn")



func reset():
	get_node("Player1").position = get_node("Spawn1").position
	get_node("Player2").position = get_node("Spawn2").position




func _on_FallArea2D_body_entered(body):
	reset()
