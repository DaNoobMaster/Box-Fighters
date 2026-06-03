extends Control


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Scences/Controls Page.tscn")


func _on_StartButton_pressed():
	get_tree().change_scene("res://Scences/Singleplayer.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()





func _on_Button_pressed():
	OS.window_fullscreen = not OS.window_fullscreen


func _on_ModeButton_pressed():
	get_tree().change_scene("res://Scences/Modes.tscn")
