#game_enums.gd
class_name GameEnums
extends Node

enum Suit {
	HEARTS,    # ♥ Corazones
	DIAMONDS,  # ♦ Diamantes
	CLUBS,     # ♣ Tréboles
	SPADES     # ♠ Picas
}

enum Rank {
	AS = 1,
	DOS = 2,
	TRES = 3,
	CUATRO = 4,
	CINCO = 5,
	SEIS = 6,
	SIETE = 7,
	SOTA = 10,
	CABALLO = 11,
	REY = 12
}

enum CardSkin {
	CLASSIC,
	MODERN,
	PIXEL_ART,
	MINIMAL
}

## Acciones posibles en el turno
enum PlayAction {
	PLAY_CARD,
	CAER,
	LEVANTAR,
	SUMAR,
	LIMPIAR
}

## Estados del juego
enum GameState {
	DRAWING_STARTER,
	DEALING,
	PLAYING,
	COUNTING,
	GAME_OVER
}

static func suit_name(suit: Suit) -> String:
	match suit:
		Suit.HEARTS:   return "Corazones"
		Suit.DIAMONDS: return "Diamantes"
		Suit.CLUBS:    return "Tréboles"
		Suit.SPADES:   return "Picas"
	return "Desconocido"

static func suit_symbol(suit: Suit) -> String:
	match suit:
		Suit.HEARTS:   return "♥"
		Suit.DIAMONDS: return "♦"
		Suit.CLUBS:    return "♣"
		Suit.SPADES:   return "♠"
	return "?"

static func rank_name(rank: Rank) -> String:
	match rank:
		Rank.AS:      return "As"
		Rank.DOS:     return "2"
		Rank.TRES:    return "3"
		Rank.CUATRO:  return "4"
		Rank.CINCO:   return "5"
		Rank.SEIS:    return "6"
		Rank.SIETE:   return "7"
		Rank.SOTA:    return "Sota"
		Rank.CABALLO: return "Caballo"
		Rank.REY:     return "Rey"
	return "Desconocido"

static func card_short_name(suit: Suit, rank: Rank) -> String:
	return rank_name(rank) + " " + suit_symbol(suit)

static func suit_key(suit: Suit) -> String:
	match suit:
		Suit.HEARTS:   return "hearts"
		Suit.DIAMONDS: return "diamonds"
		Suit.CLUBS:    return "club"
		Suit.SPADES:   return "spades"
	return "unknown"

static func rank_key(rank: Rank) -> String:
	return str(int(rank))

static func skin_folder(skin: CardSkin) -> String:
	match skin:
		CardSkin.CLASSIC:   return "classic"
		CardSkin.MODERN:    return "modern"
		CardSkin.PIXEL_ART: return "pixel_art"
		CardSkin.MINIMAL:   return "minimal"
	return "classic"

static func skin_display_name(skin: CardSkin) -> String:
	match skin:
		CardSkin.CLASSIC:   return "Clásica"
		CardSkin.MODERN:    return "Moderna"
		CardSkin.PIXEL_ART: return "Pixel Art"
		CardSkin.MINIMAL:   return "Minimalista"
	return "Clásica"
