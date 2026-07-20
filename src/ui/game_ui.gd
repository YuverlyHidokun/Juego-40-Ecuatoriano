class_name GameUI
extends CanvasLayer

@onready var caigo_button: TextureButton = $ActionButtons/CaigoButton
@onready var limpio_button: TextureButton = $ActionButtons/LimpioButton
@onready var pasar_button: TextureButton = $PlayButtons/PasarButton
@onready var jugar_button: TextureButton = $PlayButtons/JugarButton

@onready var score_label: Label = $ScorePanel/ScoreLabel
@onready var message_label: Label = $MessageLabel

func _ready() -> void:
	_setup_hover_effects()
	_disable_action_buttons()

func _setup_hover_effects() -> void:
	for button in [caigo_button, limpio_button, pasar_button, jugar_button]:
		button.mouse_entered.connect(_on_button_hover.bind(button, true))
		button.mouse_exited.connect(_on_button_hover.bind(button, false))

func _on_button_hover(button: TextureButton, hovered: bool) -> void:
	if button.disabled:
		return
	if hovered:
		button.modulate = Color(1.3, 1.3, 0.7, 1)  # Glow amarillo
	else:
		button.modulate = Color(1, 1, 1, 1)

func enable_caigo(enabled: bool) -> void:
	caigo_button.disabled = not enabled
	caigo_button.modulate = Color(1, 1, 1, 1) if enabled else Color(0.4, 0.4, 0.4, 1)

func enable_limpio(enabled: bool) -> void:
	limpio_button.disabled = not enabled
	limpio_button.modulate = Color(1, 1, 1, 1) if enabled else Color(0.4, 0.4, 0.4, 1)

func _disable_action_buttons() -> void:
	enable_caigo(false)
	enable_limpio(false)

func update_score(player: int, rival: int) -> void:
	score_label.text = "JUGADOR: %d\nRIVAL: %d" % [player, rival]

func show_message(text: String) -> void:
	message_label.text = text
