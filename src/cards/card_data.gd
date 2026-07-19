class_name CardData
extends Resource

@export var id: int = -1
@export var suit: GameEnums.Suit
@export var rank: GameEnums.Rank

## Skin actual de esta carta
var current_skin: GameEnums.CardSkin = GameEnums.CardSkin.CLASSIC

func _init(
	p_id: int = -1,
	p_suit: GameEnums.Suit = GameEnums.Suit.HEARTS,
	p_rank: GameEnums.Rank = GameEnums.Rank.AS
):
	id = p_id
	suit = p_suit
	rank = p_rank

func _to_string() -> String:
	return "%s de %s" % [
		GameEnums.rank_name(rank),
		GameEnums.suit_name(suit)
	]

func to_short_string() -> String:
	return GameEnums.card_short_name(suit, rank)

## Valor numérico base (1-12)
func get_numeric_value() -> int:
	return int(rank)

func get_envido_value() -> int:
	match rank:
		GameEnums.Rank.AS:      return 11
		GameEnums.Rank.TRES:    return 10
		GameEnums.Rank.REY:     return 4
		GameEnums.Rank.CABALLO: return 3
		GameEnums.Rank.SOTA:    return 2
		_:                      return 0  # 7, 6, 5, 4, 2

func set_skin(skin: GameEnums.CardSkin) -> void:
	current_skin = skin

func get_front_texture_path() -> String:
	var folder := GameEnums.skin_folder(current_skin)
	return "res://assets/cards/%s/%s_%s.png" % [
		folder,
		GameEnums.suit_key(suit),
		GameEnums.rank_key(rank)
	]

func get_back_texture_path() -> String:
	var folder := GameEnums.skin_folder(current_skin)
	return "res://assets/cards/%s/back.png" % folder

func is_same_suit(other: CardData) -> bool:
	return suit == other.suit

func compare_by_rank(other: CardData) -> int:
	var self_val := get_numeric_value()
	var other_val := other.get_numeric_value()
	if self_val < other_val:
		return -1
	elif self_val > other_val:
		return 1
	return 0
