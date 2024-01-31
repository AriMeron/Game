Basic Notes:
- slight recoil
- follows cursor (rotation)
- click to shoot
- hide method for when the player rolls
- projectile method (add method for when the projectile disappears)

Server:
- direction vector 
- when it was shot
- checking for collision locally
- send position location, then send a collision notification by the client who shot the bullet

Method List:
- shoot method
    - recoil
    - send projectile w click
- moving
    - attach to sprite
    - rotate according to cursor
    - move positions immediately w different walk cycle frames
- hide

Variable List:
- cursor-position: 
- projectile-type: ray vs projectile
- gun-position: x-y and angle
- shoot: boolean
- show: boolean

Resources:
How to equip and animate in 2d - Godot: https://www.youtube.com/watch?v=GPYBNdYuSD8
- using one image and then godot's animation
- create node2d for map
    - player as a kinematic body
        - save player as its own scene
        - add collisionshape2d
        - add node2d as a child