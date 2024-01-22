# Abilities

### Instance Variables

-   damage amount
-   heal amount
-   crowd control duration
-   cooldown in seconds
-   particles node

### Abstract Class with the following methods:

Effects methods:

-   damage method
    -   uses damage amount to damage the target
    -   send a packet with opponent player object and damage amount
-   heal method
    -   use heal amount to heal the user
    -   send a packet with the user object and heal amount
-   crowd control method
    -   uses crowd control duration to stun the target
    -   send a packet with opponent player object and stun duration

Use ability method:

-   takes in the opponent player object as a parameter
-   return if cooldown is not 0
-   save the start tick to keep track of the cooldown
-   call the effects methods

Check Cooldown method:

-   keep track of the number of ticks since the start tick
