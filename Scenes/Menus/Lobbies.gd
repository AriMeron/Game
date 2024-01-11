extends Control

enum lobby_status {Private, Friends, Public, Invisible}
enum search_distance {Close, Default, Far, Worldwide}

@onready var steamName = $SteamName
@onready var lobbySetName = $Create/LobbyName
@onready var lobbyGetName = $Chat/Name
@onready var lobbyOutput = $Chat/RichTextLabel
@onready var lobbyPopup = $LobbyPopup
@onready var lobbylist = $LobbyPopup/Panel/ScrollContainer/VBoxContainer
@onready var playerCount = $Players/Label
@onready var playerList = $Players/RichTextLabel
@onready var chatInput = $Message/TextEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
