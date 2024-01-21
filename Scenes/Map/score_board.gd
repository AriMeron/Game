extends CanvasLayer

var score_Dem = 0
var score_Rep = 0
var score_label_Dem
var score_label_Rep

func _ready():
	score_label_Dem = $RepublicanScore
	score_label_Rep = $DemocratScore

func update_score_Dem(points: int):
	score_Dem += points
	score_label_Dem.text = "Democrats: " + str(score_Dem)
		

func update_score_Rep(points: int):
	score_Rep += points
	score_label_Rep.text = "Republicans: " + str(score_Rep)
