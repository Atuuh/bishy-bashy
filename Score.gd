extends Label

func _on_score_updated(new_score):
	text = "Score: %.0f" % roundi(new_score)
