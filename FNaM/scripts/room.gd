extends Node2D

var is_on_table : bool = false
var is_learning : bool = false
#var math_progress = 0

func _process(delta):
	pass
	


func _on_tr_to_kit_from_rm_pressed():
	%AnimationPlayer.play("rm_to_kit")
	%GameManadger.cur_room = 2


func _on_table_room_pressed():
	is_on_table = !is_on_table
	if is_on_table:
		%AnimationPlayer.play("to_table")
		%GameManadger.is_learning = true
	else:
		%AnimationPlayer.play("from_table")
		%GameManadger.is_learning = false


func _on_tr_to_kor_from_rm_pressed():
	%AnimationPlayer.play("rm_to_kor")
	%GameManadger.cur_room = 0
