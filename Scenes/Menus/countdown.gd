extends CanvasLayer

var time_left := 60
var timer: Timer
var label: Label

func _ready():
	label = $CenterContainer/HBoxContainer/Label as Label
	timer = Timer.new()
	timer.wait_time = 1.0  # Timer will tick every second
	timer.one_shot = false  # Let the timer keep running

	# Updated signal connection using Callable
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))

	add_child(timer)
	timer.start()  # Start the timer

func _on_Timer_timeout():
	time_left -= 1  # Decrease the time left by 1 every second
	label.text = str(time_left)  # Update the label

	if time_left == 0:
		print("Countdown reached 0!")
		timer.stop()  # Stop the timer
		# Additional logic when the countdown reaches 0
