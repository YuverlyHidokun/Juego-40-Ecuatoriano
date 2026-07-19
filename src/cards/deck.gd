#deck.gd
class_name Deck
extends Resource

var cards: Array[CardData] = []

## Skin global para todo el mazo
var current_skin: GameEnums.CardSkin = GameEnums.CardSkin.CLASSIC

func _init(p_skin: GameEnums.CardSkin = GameEnums.CardSkin.CLASSIC) -> void:
	current_skin = p_skin
	create_deck()

func create_deck() -> void:
	cards.clear()
	var id := 0

	for suit in GameEnums.Suit.values():
		for rank in GameEnums.Rank.values():
			var card = CardData.new(id, suit, rank)
			card.set_skin(current_skin)
			cards.append(card)
			id += 1

	print("Mazo creado: ", cards.size(), " cartas (skin: ", GameEnums.skin_display_name(current_skin), ")")

func shuffle(p_seed: int = -1) -> void:
	if p_seed >= 0:
		seed(p_seed)
		print("Barajando con seed: ", p_seed)
	else:
		randomize()

	for i in range(cards.size() - 1, 0, -1):
		var j := randi() % (i + 1)
		var temp := cards[i]
		cards[i] = cards[j]
		cards[j] = temp

	print("Mazo barajado")

func set_skin(new_skin: GameEnums.CardSkin) -> void:
	current_skin = new_skin
	for card in cards:
		card.set_skin(new_skin)
	print("Skin cambiada a: ", GameEnums.skin_display_name(new_skin))

func draw() -> CardData:
	if cards.is_empty():
		push_error("¡El mazo está vacío!")
		return null
	return cards.pop_back()

func deal(amount: int) -> Array[CardData]:
	var hand: Array[CardData] = []
	for i in range(amount):
		var card := draw()
		if card:
			hand.append(card)
	return hand

func is_empty() -> bool:
	return cards.is_empty()

func remaining() -> int:
	return cards.size()

func print_deck() -> void:
	for card in cards:
		print(card)
