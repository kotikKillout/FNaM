extends Node2D

var math_progress = 0
var is_on_table : bool = false
var is_learning : bool = false
@onready var room = %Room



func _process(delta):
	pass
	



func _on_tr_to_rm_from_kor_pressed():
	%AnimationPlayer.play("kor_to_rm")
	%GameManadger.cur_room = 1


func _on_table_kor_pressed():
	is_on_table = !is_on_table
	if is_on_table:
		%AnimationPlayer.play("to_table_kor")
		%GameManadger.is_learning = true
	else:
		%AnimationPlayer.play("from_table_kor")
		%GameManadger.is_learning = false

