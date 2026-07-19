# game_enums.gd
class_name GameEnums
extends Node

enum Suit {
	HEARTS,
	DIAMONDS,
	CLUBS,
	SPADES
}

enum Rank {
	AS = 1,
	DOS = 2,
	TRES = 3,
	CUATRO = 4,
	CINCO = 5,
	SEIS = 6,
	SIETE = 7,
	JOTA = 10,
	REINA = 11,
	REY = 12
}

static func suit_name(suit: Suit) -> String:
	match suit:
		Suit.HEARTS: return "Corazones"
		Suit.DIAMONDS: return "Diamantes"
		Suit.CLUBS: return "Tréboles"
		Suit.SPADES: return "Picas"
	return "Desconocido"

static func suit_symbol(suit: Suit) -> String:
	match suit:
		Suit.HEARTS: return "♥"
		Suit.DIAMONDS: return "♦"
		Suit.CLUBS: return "♣"
		Suit.SPADES: return "♠"
	return "?"

static func rank_name(rank: Rank) -> String:
	match rank:
		Rank.AS: return "As"
		Rank.DOS: return "2"
		Rank.TRES: return "3"
		Rank.CUATRO: return "4"
		Rank.CINCO: return "5"
		Rank.SEIS: return "6"
		Rank.SIETE: return "7"
		Rank.JOTA: return "J"
		Rank.REINA: return "Q"
		Rank.REY: return "K"
	return "Desconocido"

static func card_short_name(suit: Suit, rank: Rank) -> String:
	return rank_name(rank) + " " + suit_symbol(suit)
