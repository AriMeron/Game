extends Node

@export var Address = "127.0.0.1"
@export var port = 8910
var peer

func _ready():
	# Server initialization code here
	pass

func start_server():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 6)
	if error != OK:
		print("cannont host:" + str(error))
		return
	
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting For Players!")
	
	# SendPlayerInformation($LineEdit.text, multiplayer.get_unique_id())
	
	# Code to start the server
	pass
