extends Control



func _on_SingleButton_pressed():
	get_tree().change_scene("res://Scences/Main Menu2.tscn")


func _on_Doublebutton_pressed():
	get_tree().change_scene("res://Scences/Main Menu.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
