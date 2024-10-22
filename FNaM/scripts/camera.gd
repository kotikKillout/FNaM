extends Node2D
@onready var room = %Room
@onready var hungr_progr_bar = $CanvasLayer/HungerProgressBar
@onready var stress_progress_bar = $CanvasLayer/StressProgressBar


#var is_learning = room.is_learning
var cur_hour = -1
var is_learning : bool = false
var cur_room = 1 #0=koridor 1=room 2=kitchen
var cur_state = 0 #0=play 1=win 2=lose
var math_progress = 0
var hunger = 100
var stress = 0
var stressing = 0
var is_on_phone : bool = false

var danger = 0 #0=nothing 1=alarm 2=shooting 3=SHAHED!!!


func _ready():
	n_hour() 
	$TimerSiren.start()
	$MusicStreamPlayer.play()
	%GameOverLabel.hide()
	
func _process(delta):
	learning()
	starving(delta)
	handle_stress(delta)
	handle_state()
	#print($TimerSiren.time_left)
	
	
	
	
	%Debug_label.text = " "
	%Debug_label.text = "Is_learning = "+str(is_learning)
	%Debug_label.text += "\nDanger lvl = "+str(danger)
	%Debug_label.text += "\nCurrent room = "+str(cur_room)
	
	if cur_hour ==0:
		%Hours_label.text = ""
		%Hours_label.text = str(12) + " PM"
	else:
		%Hours_label.text = ""
		%Hours_label.text = str(cur_hour) + " AM"
	
	#Engine.time_scale = 10
	


func handle_state():
	if hunger <=0 or stress>=100:
		cur_state = 1
		iris()
	elif stress<100 and hunger>0 and math_progress >= 100 and cur_hour == 5:
		cur_state = 2
		iris()

func iris():
	%GameOverLabel.show()
	if cur_state == 2: #loose
		%GameOverLabel.text = "YOU WIN!"
		if %IrisOut.scale.x>1:
			%IrisOut.scale.x-=0.4
			%IrisOut.scale.y-=0.4
		else:
			get_tree().change_scene_to_file("res://scenes/menu.tscn")
	if cur_state == 1: #win
		%GameOverLabel.text = "GAME OVER"
		if %IrisOut.scale.x>1:
			%IrisOut.scale.x-=0.4
			%IrisOut.scale.y-=0.4
		else:
			get_tree().change_scene_to_file("res://scenes/menu.tscn")


func learning():
	if is_learning == true:
		math_progress += 0.015
		%MathProgressBar.value = math_progress
		#print(str(math_progress))
		#print(str(is_learning))
	else:
		pass



func n_hour():
	print("NEW HOUR")
	if cur_hour <=5:
		print(str(cur_hour))
		cur_hour+=1
		$Timer.wait_time = 60
		$Timer.start()
	else:
		print("win")
	pass


func _on_timer_timeout():
	n_hour()


#STARVING
func starving(delta):
	hunger -= 0.8*delta
	#print(hunger)
	hungr_progr_bar.value = hunger

#PHONE
func _on_phone_button_pressed():
	is_on_phone = !is_on_phone
	if is_on_phone == true:
		$CanvasLayer/MarginContainer2/AnimationPlayer.play("phone_up")
	else:
		$CanvasLayer/MarginContainer2/AnimationPlayer.play("phone_down")



#STRESS

func handle_stress(delta):
	
	if Input.is_action_just_pressed("1"):
		danger = 1
	elif Input.is_action_just_pressed("2"):
		danger = 2
	elif Input.is_action_just_pressed("3"):
		danger = 3
	if stress >= 0 and stress<=100:
		stress += stressing*delta
		#print(stress)
		#print(danger)
	stress_progress_bar.value = stress
	
	if danger == 1:
		stressing = 2
	elif danger == 2:
		stressing = 5
	elif danger == 3:
		stressing = 10
	elif danger == 0 and stress>2:
		stressing -= 2
	if cur_room == 0:
		if stress>=2:
			stressing = -2
		else:
			stress = 0





var rng = RandomNumberGenerator.new()
var varient = rng.randf_range(0, 10.0)

#@export var max_s_time = 100
@export var rem_s_time = 120

var sir_prob = 4

### AIR SIREN

#func handle_siren():
	#if rem_s_time >0:
		#if rng.randf_range(0, 10.0) <=4:





func _on_timer_siren_timeout():
	if rem_s_time >0:
		print("trying to remake siren")
		if danger==0 and rng.randf_range(0, 10.0) <=4:
			print("setting danger to 1")
			danger = 1
			rem_s_time-=30
			$TimerSiren.start()
			$SirenStreamPlayer.play()
		elif danger==1:
			if rng.randf_range(0, 10.0) <=2:
				print("setting danger to 2")
				danger = 2
				rem_s_time-=30
				$TimerSiren.start()
				$ShootingStreamPlayer.play()
			elif rng.randf_range(0, 10)<=2:
				print("setting danger to 0 from 1")
				danger = 0
				$TimerSiren.start()
				$VidbiyStreamPlayer.play()
		elif danger==2:
			if rng.randf_range(0, 10.0) <=1:
				print("setting danger to 3")
				danger = 3
				rem_s_time-=30
				$TimerSiren.start()
				#$SirenStreamPlayer.play()
			elif rng.randf_range(0, 10)<=4:
				print("setting danger to 1 from 2")
				danger = 1
				rem_s_time-=30
				$TimerSiren.start()
		elif danger==2:
			if rng.randf_range(0, 10)<=4:
				print("setting danger to 1 from 3")
				danger = 1
				rem_s_time-=30
				$TimerSiren.start()
	else:
		danger = 0
