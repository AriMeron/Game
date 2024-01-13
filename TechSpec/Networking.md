### Networking

- TCP Protocal

Example Lobby in Godot

- https://docs.godotengine.org/en/stable/tutorials/networking/high_level_multiplayer.html#example-lobby-implementation

## Tick System

- 20 ticks per second
- Every tick, each object (player, map, etc.) sends a package to the server through TCP protocol

## Packages to Server

- Player
  - Position
  - Health
  - All Actions
    - Opening/Closing Doors
    - Shooting Guns
    - Using Ability
- Map
  - Doors being open or not

## Purpose of Server

-Player position

- Server keeps track of player position and sends out the coordinates of each player
- Gun firing
  - Player sends package with vector of bullet
  - Vector is sent to other players and displayed on their screen
  - Bullet tracks collision client side and sends collision to server
  - Server then sends health data, etc. to all players
- Abilities
  - Similar to guns, depending on what the ability does
- Map
  - Displays on the map what doors are open for all players
  - When a player opens/closes a door, all players can see it
- Health
  - Health is stored client side
  - Player send health every package
  - Health of each player is then sent to other players to be displayed above their heads

## Accounting for lag and bad wifi

-
