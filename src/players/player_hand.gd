class_name PlayerHand
extends Node2D

signal card_played(card_data: CardData)
signal hand_changed

@export var card_scene: PackedScene
@export var card_spacing: float = 70.0
@export var max_cards: int = 5

var cards: Array[Card] = []
var selected_card: Card = null

func add_card(data: CardData, face_up: bool = true) -> void:
	if cards.size() >= max_cards:
		push_warning("Mano llena")
		return
	
	if card_scene == null:
		push_error("Card scene no asignada")
		return
	
	var card: Card = card_scene.instantiate()
	card.setup(data)
	card.flip(face_up, false)
	
	card.card_clicked.connect(_on_card_clicked)
	card.card_hovered.connect(_on_card_hovered)
	card.card_unhovered.connect(_on_card_unhovered)
	
	add_child(card)
	cards.append(card)
	
	_arrange_cards()
	hand_changed.emit()

func add_cards(data_array: Array[CardData], face_up: bool = true) -> void:
	for data in data_array:
		add_card(data, face_up)

func play_selected_card() -> CardData:
	if selected_card == null:
		return null
	
	var data := selected_card.card_data
	cards.erase(selected_card)
	
	selected_card.card_clicked.disconnect(_on_card_clicked)
	selected_card.card_hovered.disconnect(_on_card_hovered)
	selected_card.card_unhovered.disconnect(_on_card_unhovered)
	
	remove_child(selected_card)
	selected_card.queue_free()
	selected_card = null
	
	_arrange_cards()
	hand_changed.emit()
	card_played.emit(data)
	return data

func clear_hand() -> void:
	for card in cards:
		card.queue_free()
	cards.clear()
	selected_card = null

func _arrange_cards() -> void:
	var total_width := (cards.size() - 1) * card_spacing
	var start_x := -total_width / 2.0
	
	for i in range(cards.size()):
		cards[i].position = Vector2(start_x + i * card_spacing, 0)

func _on_card_clicked(card: Card) -> void:
	if selected_card == card:
		# click de nuevo sobre la misma carta -> deseleccionar
		card.set_selected(false)
		selected_card = null
	else:
		# deseleccionar la anterior (si había) y seleccionar la nueva
		if selected_card != null:
			selected_card.set_selected(false)
		card.set_selected(true)
		selected_card = card

func _on_card_hovered(card: Card) -> void:
	pass

func _on_card_unhovered(card: Card) -> void:
	pass

func get_card_count() -> int:
	return cards.size()

func has_selected_card() -> bool:
	return selected_card != null
