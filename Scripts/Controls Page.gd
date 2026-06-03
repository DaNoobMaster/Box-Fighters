extends Control




func _on_ControlsButton_pressed():
	$Popup.popup_centered_ratio(0.75)


func _on_BackButton_pressed():
	get_tree().change_scene("res://Scences/Root.tscn")


func _on_AttacksButton_pressed():
	$popup.popup_centered_ratio(1)


func _on_Button_pressed():
	$AcceptDialog.popup_centered_ratio(0.7)
