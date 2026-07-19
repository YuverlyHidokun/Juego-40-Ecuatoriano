class_name GameBoard
extends Node2D

const TABLE_SCENE := preload("res://src/board/table.tscn")
const CARDS_PER_HAND := 5

@onready var table_position: Marker2D = $TablePosition
@onready var player_hand_position: Marker2D = $PlayerHandPosition
@onready var opponent_hand_position: Marker2D = $OpponentHandPosition
@onready var deck_position: Marker2D = $DeckPosition

@onready var player_hand: PlayerHand = $PlayerHand
@onready var opponent_hand: PlayerHand = $OpponentHand

@onready var score_label: Label = $UI/ScoreLabel
@onready var message_label: Label = $UI/MessageLabel
@onready var play_button: Button = $UI/ButtonsContainer/PlayButton
@onready var pass_button: Button = $UI/ButtonsContainer/PassButton

var deck: Deck
var table: Table
var player_score: int = 0
var opponent_score: int = 0


func _ready() -> void:
	deck = Deck.new()
	deck.shuffle()

	# Crear mesa
	table = TABLE_SCENE.instantiate()
	table.position = table_position.position
	add_child(table)

	player_hand.position = player_hand_position.position
	opponent_hand.position = opponent_hand_position.position

	play_button.pressed.connect(_on_play_pressed)
	pass_button.pressed.connect(_on_pass_pressed)

	_deal_initial_hands()
	_update_score_label()
	_set_message("Selecciona una carta y presiona Jugar")


func _deal_initial_hands() -> void:
	player_hand.add_cards(deck.deal(CARDS_PER_HAND), true)
	opponent_hand.add_cards(deck.deal(CARDS_PER_HAND), false)


func _on_play_pressed() -> void:
	if not player_hand.has_selected_card():
		_set_message("Selecciona una carta para jugar")
		return
	
	var card_data := player_hand.play_selected_card()
	table.add_card(card_data)
	_check_rules(card_data)


func _check_rules(card_data: CardData) -> void:
	var messages: Array[String] = []
	
	# Verificar caída
	if table.can_caer(card_data):
		messages.append("¡CAÍDA! +2 puntos")
		player_score += 2
	
	# Verificar levantar consecutivas
	var levantar_indices := table.get_levantar_indices(card_data)
	if not levantar_indices.is_empty():
		messages.append("Levantas cartas consecutivas")
		table.remove_cards(levantar_indices)
	
	# Verificar sumar
	var sumar_indices := table.get_sumar_indices(card_data)
	if not sumar_indices.is_empty():
		messages.append("Sumas cartas de la mesa")
		table.remove_cards(sumar_indices)
	
	# Verificar limpia
	if table.is_empty():
		messages.append("¡LIMPIA! +2 puntos")
		player_score += 2
	
	if messages.is_empty():
		_set_message("Jugaste " + card_data.to_short_string())
	else:
		_set_message("\n".join(messages))
	
	_update_score_label()


func _on_pass_pressed() -> void:
	_set_message("Pasaste el turno")


func _update_score_label() -> void:
	score_label.text = "Vos: %d   Rival: %d" % [player_score, opponent_score]


func _set_message(text: String) -> void:
	message_label.text = text
