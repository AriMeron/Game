extends Control

var server_script = preload("res://Scripts/Server.gd");



func _on_host_lan_pressed():
	_initialize_as_host()  # Assuming there's a method named 'start_server' in your Server.gd
	print("host pressed")
	pass # Replace with function body.


func _on_join_lobby_pressed():
	_initialize_as_client()
	print("join pressed")
	# initialize as client
	pass # Replace with function body.


func _on_host_internet_pressed():
	# Start game StartGame.rpc()
	pass # Replace with function body.


func _on_start_game_button_down():

	_start_game_button_down()
	print("start game pressed")
	pass # Replace with function body.

@export var Address = "127.0.0.1"
@export var port = 8910
var peer

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	pass # Replace with function body.

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

# When you start game, create a map and a character for each player
@rpc("any_peer", "call_local")
func StartGame():
	var map = load ("res://Scenes/Map/map_final.tscn").instantiate()
	get_tree().root.add_child(map)
	var player = load ("res://Scenes/Characters/CharacterPlayground.tscn").instantiate()
	get_tree().root.add_child(player)
	self.hide()

func _initialize_as_host():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 6)
	if error != OK:
		print("cannont host:" + error)
		return

	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)

	print("Waiting For Players!")
	SendPlayerInformation("name test", multiplayer.get_unique_id())
	pass # Replace with function body.

func _start_game_button_down():
	StartGame.rpc()
	pass # Replace with function body.

func _initialize_as_client():
	var peer2 = ENetMultiplayerPeer.new()
	var error = peer2.create_client(Address, port)
	if error != OK:
		print("cannont create client:" + error)
		return
	peer2.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer2)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_view_assets_button_down():
	pass # Replace with function body.

func _on_load_map_button_down():
	pass # Replace with function body.

func _on_test_movement_button_down():
	pass # Replace with function body.

func _on_node_load_example_button_down():
	var scene = load("res://Scenes/Menus/ExampleScene.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

func peer_connected(id):
	print("Player Connected " + str(id))

func peer_disconnected(id):
	print("Player Disconnected " + str(id))

func connected_to_server():
	print("Connected to Server!")
	SendPlayerInformation.rpc_id(1, "test_name", multiplayer.get_unique_id())

func connection_failed(id):
	print("Couldn't Connect")


var test_scene = preload("res://Scenes/Map/test_scene.tscn");
func _on_settings_pressed():
	var instance = test_scene.instantiate()
	get_tree().root.add_child(instance)
	self.queue_free()
	#get_tree().change_scene_to(test_scene)
	pass # Replace with function body.
