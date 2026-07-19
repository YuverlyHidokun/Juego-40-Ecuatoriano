# deck.gd
class_name Deck
extends Resource

var cards: Array[CardData] = []

func _init() -> void:
	create_deck()

func create_deck() -> void:
	cards.clear()
	for suit in GameEnums.Suit.values():
		for rank in GameEnums.Rank.values():
			var card = CardData.new(suit, rank)
			cards.append(card)
	print("Mazo creado: ", cards.size(), " cartas")

func shuffle() -> void:
	for i in range(cards.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		var temp = cards[i]
		cards[i] = cards[j]
		cards[j] = temp
	print("Mazo barajado")

func draw() -> CardData:
	if cards.is_empty():
		push_error("¡El mazo está vacío!")
		return null
	return cards.pop_back()

func deal(amount: int) -> Array[CardData]:
	var hand: Array[CardData] = []
	for i in range(amount):
		var card = draw()
		if card:
			hand.append(card)
	return hand

func print_deck() -> void:
	for card in cards:
		print(card)
