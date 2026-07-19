class_name Card
extends Area2D

signal card_clicked(card: Card)
signal card_hovered(card: Card)
signal card_unhovered(card: Card)

@onready var front_sprite: Sprite2D = $Front
@onready var back_sprite: Sprite2D = $Back
@onready var selection_rect: ColorRect = $Selection
@onready var anim_player: AnimationPlayer = $AnimationPlayer

var card_data: CardData = null
var is_face_up: bool = false
var is_selected: bool = false
var is_interactable: bool = true

func _ready() -> void:
	_update_textures()
	_update_visibilities()

func setup(data: CardData) -> void:
	card_data = data
	_update_textures()

func _update_textures() -> void:
	if card_data == null or front_sprite == null:
		return
	
	var front_path := card_data.get_front_texture_path()
	var back_path := card_data.get_back_texture_path()
	
	if ResourceLoader.exists(front_path):
		front_sprite.texture = load(front_path)
	else:
		push_warning("No se encontró textura frontal: " + front_path)
	
	if ResourceLoader.exists(back_path):
		back_sprite.texture = load(back_path)
	else:
		push_warning("No se encontró textura trasera: " + back_path)

func _update_visibilities() -> void:
	if front_sprite == null or back_sprite == null or selection_rect == null:
		return
	front_sprite.visible = is_face_up
	back_sprite.visible = not is_face_up
	selection_rect.visible = is_selected

func flip(face_up: bool, animated: bool = true) -> void:
	if is_face_up == face_up:
		return
	
	is_face_up = face_up
	
	if front_sprite == null:
		return
	
	if animated and anim_player.has_animation("flip"):
		anim_player.play("flip")
	else:
		front_sprite.visible = is_face_up
		back_sprite.visible = not is_face_up

func flip_toggle(animated: bool = true) -> void:
	flip(not is_face_up, animated)

func set_selected(selected: bool) -> void:
	is_selected = selected
	if selection_rect != null:
		selection_rect.visible = is_selected

func toggle_selected() -> void:
	set_selected(not is_selected)

func set_interactable(enabled: bool) -> void:
	is_interactable = enabled

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if not is_interactable:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			card_clicked.emit(self)
			toggle_selected()

func _mouse_enter() -> void:
	if is_interactable:
		card_hovered.emit(self)
		modulate = Color(1.1, 1.1, 1.1)

func _mouse_exit() -> void:
	if is_interactable:
		card_unhovered.emit(self)
		modulate = Color(1, 1, 1)

func get_suit() -> GameEnums.Suit:
	return card_data.suit if card_data else GameEnums.Suit.HEARTS

func get_rank() -> GameEnums.Rank:
	return card_data.rank if card_data else GameEnums.Rank.AS

func get_envido_value() -> int:
	return card_data.get_envido_value() if card_data else 0

func _to_string() -> String:
	return card_data.to_string() if card_data else "Carta vacía"
