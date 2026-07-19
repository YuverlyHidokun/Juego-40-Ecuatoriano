class_name ScoreManager
extends Node

var team_a_score: int = 0
var team_b_score: int = 0

const WIN_SCORE: int = 40
const CAIDA_POINTS: int = 2
const LIMPIA_POINTS: int = 2
const SHUNSHO_PENALTY: int = 2

func add_caida(team: int) -> void:
	_add_points(team, CAIDA_POINTS)

func add_limpia(team: int) -> void:
	_add_points(team, LIMPIA_POINTS)

func add_shunsho_penalty(team: int) -> void:
	var rival := 1 if team == 0 else 0
	_add_points(rival, SHUNSHO_PENALTY)

func count_cards(cards_won: int, team: int) -> void:
	if cards_won <= 20:
		return
	
	var extra_cards := cards_won - 18
	var points := 5 + extra_cards
	
	if points % 2 != 0:
		points += 1
	
	_add_points(team, points)

func _add_points(team: int, points: int) -> void:
	if team == 0 and team_a_score >= 38:
		return
	if team == 1 and team_b_score >= 38:
		return
	
	if team == 0:
		team_a_score = mini(team_a_score + points, WIN_SCORE)
	else:
		team_b_score = mini(team_b_score + points, WIN_SCORE)

func get_score(team: int) -> int:
	return team_a_score if team == 0 else team_b_score

func is_38(team: int) -> bool:
	return get_score(team) == 38

func has_won(team: int) -> bool:
	return get_score(team) >= WIN_SCORE

func reset() -> void:
	team_a_score = 0
	team_b_score = 0
