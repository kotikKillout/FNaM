extends Node2D

func _ready():
	$AudioStreamPlayer.play()


func _on_game_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_settings_pressed():
	$Camera2D/AnimationPlayer.play("to_settings")


func _on_back_to_menu_pressed():
	$Camera2D/AnimationPlayer.play("to_menu")
