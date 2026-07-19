class_name Table
extends Node2D

signal table_changed
signal limpia_made(team: int)

var cards_on_table: Array[CardData] = []
var card_visuals: Array[Card] = []

@export var card_scene: PackedScene
@export var card_spacing: float = 40.0

func add_card(card_data: CardData) -> void:
	cards_on_table.append(card_data)
	_create_visual(card_data)
	table_changed.emit()

func _create_visual(card_data: CardData) -> void:
	if card_scene == null:
		return
	
	var card: Card = card_scene.instantiate()
	card.setup(card_data)
	card.flip(true, false)
	card.set_interactable(false)
	
	var x_pos: float = (cards_on_table.size() - 1) * card_spacing
	card.position = Vector2(x_pos - (cards_on_table.size() * card_spacing / 2.0), 0)
	
	add_child(card)
	card_visuals.append(card)

func remove_cards(indices: Array[int]) -> Array[CardData]:
	var removed: Array[CardData] = []
	
	var sorted_indices: Array[int] = indices.duplicate()
	sorted_indices.sort()
	sorted_indices.reverse()
	
	for i: int in sorted_indices:
		removed.append(cards_on_table[i])
		cards_on_table.remove_at(i)
		card_visuals[i].queue_free()
		card_visuals.remove_at(i)
	
	_rearrange_visuals()
	table_changed.emit()
	return removed

func remove_all() -> Array[CardData]:
	var all: Array[CardData] = cards_on_table.duplicate()
	
	for visual: Card in card_visuals:
		visual.queue_free()
	
	cards_on_table.clear()
	card_visuals.clear()
	table_changed.emit()
	return all

func _rearrange_visuals() -> void:
	for i: int in range(card_visuals.size()):
		var x_pos: float = i * card_spacing
		card_visuals[i].position = Vector2(x_pos - (card_visuals.size() * card_spacing / 2.0), 0)

func can_caer(card: CardData) -> bool:
	if cards_on_table.is_empty():
		return false
	var top_card: CardData = cards_on_table.back()
	return card.rank == top_card.rank

func get_levantar_indices(card: CardData) -> Array[int]:
	var indices: Array[int] = []
	if cards_on_table.is_empty():
		return indices
	
	var top_card: CardData = cards_on_table.back()
	if card.rank != top_card.rank:
		return indices
	
	var next_rank: int = int(card.rank) + 1
	for i: int in range(cards_on_table.size() - 2, -1, -1):
		var table_card: CardData = cards_on_table[i]
		if int(table_card.rank) == next_rank:
			indices.append(i)
			next_rank += 1
		else:
			break
	
	return indices

func get_sumar_indices(card: CardData) -> Array[int]:
	var indices: Array[int] = []
	if cards_on_table.size() < 2:
		return indices
	
	var target: int = int(card.rank)
	
	for i: int in range(cards_on_table.size()):
		for j: int in range(i + 1, cards_on_table.size()):
			var sum: int = int(cards_on_table[i].rank) + int(cards_on_table[j].rank)
			if sum == target:
				return [i, j]
	
	for i: int in range(cards_on_table.size()):
		for j: int in range(i + 1, cards_on_table.size()):
			for k: int in range(j + 1, cards_on_table.size()):
				var sum: int = int(cards_on_table[i].rank) + int(cards_on_table[j].rank) + int(cards_on_table[k].rank)
				if sum == target:
					return [i, j, k]
	
	return indices

func is_empty() -> bool:
	return cards_on_table.is_empty()

func clear() -> void:
	cards_on_table.clear()
	for visual: Card in card_visuals:
		visual.queue_free()
	card_visuals.clear()
