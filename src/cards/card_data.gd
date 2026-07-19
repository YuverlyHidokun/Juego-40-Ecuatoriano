# card_data.gd
class_name CardData
extends Resource

@export var suit: GameEnums.Suit
@export var rank: GameEnums.Rank
@export var texture: Texture2D

func _init(p_suit: GameEnums.Suit = GameEnums.Suit.HEARTS, p_rank: GameEnums.Rank = GameEnums.Rank.AS) -> void:
	suit = p_suit
	rank = p_rank

func _to_string() -> String:
	return GameEnums.rank_name(rank) + " de " + GameEnums.suit_name(suit)

func to_short_string() -> String:
	return GameEnums.card_short_name(suit, rank)

func get_numeric_value() -> int:
	return int(rank)
