This file should explain who knows what capabilities of the Godot engine. If you are researching something, please put the research topic, tutorials used, and goal.

**Capabilities Needed** 0. Class diagram of all items

1. Multiplayer
   a. Server / Client configuration
2. Data Storage
   a. Client-side data - Mr.T
   b. Server-side data

// Capabilities people have with the game engine
// TODO - organize these as they expand in scope
**Capabilites Understood:**

<<<<<<< Updated upstream
- Tilemap Creation -

\*\*Networking Capabilities

- Added List of packages that have to be sent and received from all client-side objects
- Includes player, map, and weapons
=======
-   Tilemap Creation -

**Ability Capabilities**

-   Receives Player information and Opponent ID from the player object and has functions to return damage, heal and stun effects to the player
-   the ability sends a packet to the server with the player ID, opponent ID, and the ability ID
-   the opponent ID then takes the ability ID and then pulls the damage, heal, and stun effects from the ability class using the ability ID
>>>>>>> Stashed changes
