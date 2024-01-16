extends Control

@export var Address = "127.0.0.1"
@export var port = 8910
const PROTO_NAME = "ludus"

var peer = null
@onready var nameEdit = $Username/TextEdit
@onready var lobbySetName = $Create/LobbyName
@onready var lobbyGetName = $Chat/Name
@onready var lobbyOutput = $Chat/RichTextLabel
@onready var lobbies = $Lobbies
@onready var lobbyList = $Lobbies/Panel/ScrollContainer/VBoxContainer
@onready var playerCount = $Players/Label
@onready var playersList = $Players/RichTextLabel
@onready var chatInput = $Message/TextEdit




# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	
	pass # Replace with function body.

func peer_connected(id):
	print("Player Connected " + str(id))

func peer_disconnected(id):
	print("Player Disconnected " + str(id))

func connected_to_server():
	print("Connected to Server!")
	SendPlayerInformation.rpc_id(1, $LineEdit.text, multiplayer.get_unique_id())

func connection_failed(id):
	print("Couldn't Connect")

@rpc("any_peer")
func SendPlayerInformation(name,id):
	if !GameManager.Players.has(id):
		GameManager.Players[id] = {
			"name": name,
			"id": id,
			"score": 0
		}
	
	if multiplayer.is_server():
		for i in GameManager.Players:
			SendPlayerInformation.rpc(GameManager.Players[i].name, i)
		

@rpc("any_peer", "call_local")
func StartGame():
	var scene = load ("res://Scenes/Player/DemoPlayerSpace.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

func _on_join_button_down():
	lobbies.popup()
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
func _on_Lobby_Match_List(lobbies):
	for LOBBY in lobbies:
		##get data for these two variables
		var LOBBY_NAME = ""##add network code here
		var LOBBY_MEMBERS = ""## and here
		
		var LOBBY_BUTTON = Button.new()
		LOBBY_BUTTON.set_text("Lobby "+str(LOBBY)+" : "+ str(LOBBY_NAME)+"- ["+str(LOBBY_MEMBERS)+"] Players(s)")
		LOBBY_BUTTON.set_size(Vector2(800,50))
		LOBBY_BUTTON.set_name("lobby_"+str(LOBBY))
		LOBBY_BUTTON.connect("pressed",self,"join_Lobby",[LOBBY])
		lobbyList.add_child(LOBBY_BUTTON)
		

func join_Lobby(lobbyID):
	pass


func _on_close_button_down():
	lobbies.hide()


func _on_host_button_down():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 6)
	if error != OK:
		print("cannont host:" + error)
		return
	
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting For Players!")
	
	SendPlayerInformation($LineEdit.text, multiplayer.get_unique_id())
	
