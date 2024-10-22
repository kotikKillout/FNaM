extends Node2D

@onready var butery = $Butery
@onready var but_progress_bar = $ButProgressBar
var on_table:bool = false
var but_prog = 0
var kil_but = 0

func _process(delta):
	gotovka()


func _on_tr_to_rm_from_kit_pressed():
	%AnimationPlayer.play("kit_to rm")
	%GameManadger.cur_room = 1


func _on_table_kit_pressed():
	on_table=!on_table
	if on_table == true:
		%AnimationPlayer.play("to_table_kit")
	elif on_table == false:
		%AnimationPlayer.play("from_table_kit")

func gotovka():
	if on_table == true and kil_but < 3 and but_prog<100:
		but_prog +=0.3
	elif on_table == false:
		but_prog = 0
	if but_prog >= 100:
		kil_but +=1
		but_prog = 0
	but_progress_bar.value = but_prog
	butery.text = str(kil_but)


func _on_texture_button_pressed():
	if kil_but>0:
		if %GameManadger.hunger>90:
			%GameManadger.hunger=100
			if %GameManadger.stress>=11:
				%GameManadger.stress -=10
			else:
				%GameManadger.stress = 0
			kil_but-=1
		elif %GameManadger.hunger<90:
			%GameManadger.hunger+=10
			if %GameManadger.stress>=11:
				%GameManadger.stress -=10
			else:
				%GameManadger.stress = 0
			kil_but-=1
