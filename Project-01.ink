VAR Health = 10

VAR Cealth = 5

VAR Pet_name = ""

VAR Torches = 0

VAR Time = -1 // 0 Morning, 1 Noon, 2 Night

-> Memory

==Memory==
It is {advance_time()}
Before you is the Mouth of the Cavern
If you wish you may summon a creature to accompany you throughout your journey.

+ [Imp]
    ~ Pet_name = "Imp"
    -> Imp
    
+ [Puedodragon]
    ~ Pet_name = "Peudodragon"
    -> Puedodragon

+ [Quasit]
    ~ Pet_name = "Quasit"
    -> Quasit

+ [Turn Around] -> Home

==Home==
Today you decided not to cavern dive... Maybe another day
-> END

==Imp==
Are you sure you want this creature?
+[Yes] -> cave_mouth
+[No] -> Memory

==Puedodragon==
Are you sure you want this creature?
 +[Yes] -> cave_mouth
+[No] -> Memory

==Quasit==
Are you sure you want this creature?
+[Yes] -> cave_mouth
+[No] -> Memory

== cave_mouth ==
{Health}HP
It is {advance_time()}
You enter the cave. {not torch_pickup:There is a torch on the floor.} The cave extends to the east and west.

{Pet_name} Is sitting on your shoulder and starring deeper into the cave

You have {Torches} Torch uses left

+ [Take the east tunnel] -> east_tunnel
+ [Take the west tunnel] -> west_tunnel
* [Pick up the torch] -> torch_pickup

== east_tunnel ==
{Health}HP
It is {advance_time()}
You are in the east tunnel. It is very dark, you can't see anything.
* {Torches > 0} [Light Torch] -> east_tunnel_lit
+ [Go Back] -> cave_mouth
-> END

== west_tunnel ==
{Health}HP
It is {advance_time()}
You are in the west tunnel. It is very dark, you can't see anything.
* {Torches > 0} [Light Torch] -> west_tunnel_lit
+ [Go Back] -> cave_mouth
-> END

=== torch_pickup ===
{Health}HP
You pick up the torch, and your {Pet_name} stares into the fire with its big eyes.
 ~ Torches = Torches +5
* [Go Back] -> cave_mouth
-> END

== east_tunnel_lit ==
The light of your torch glints off of the thousands of coins in the room.
The room contained a health container +15 to max HP
 ~ Health = Health +15
 ~ Torches = Torches -1
-> east_tunnel

== west_tunnel_lit ==
{Health}HP
The room has a locked chest
~ Torches = Torches -1
* { Health < 25} [You can't break open the chest you aren't strong enough] -> cave_mouth
* { Health == 25} [Attempt to break open the chest] -> Chest

==Chest==
The Chest jumps out at you

{Pet_name == "Imp": {Pet_name} Throws fire at the Chest Mimc} -> Chest_Damage

{Pet_name == "Puedodragon": {Pet_name}Spits fire at the Chest Mimic} -> Chest_Damage

{Pet_name == "Quasit": {Pet_name} Slashes at the Chest Mimc} -> Chest_Damage

==Chest_Damage==

It is {advance_time()}

{&You begin to see a glare from beyond the horizon|The Sun beats down heavy on your face|You face begins to cool with the sun down}

Mimc took 1 Damage it is now at

 ~ Cealth = Cealth -1
{Cealth} 

The Mimc bites towards you, you take 3 Damage

 ~ Health = Health -3

{Health}

+ {Cealth != 0}[Attack] -> Chest_Damage
* {Cealth == 0} [You Win!!!] -> WIN

==WIN==
The Mimic starts spewing Gold from its body
-> END

== function advance_time ==

    ~ Time = Time + 1
    
    {
        - Time > 2:
            ~ Time = 0
    }    

    {    
        - Time == 0:
            ~ return "Morning"
        
        - Time == 1:
            ~ return "Noon"
        
        - Time == 2:
            ~ return "Night"
    }

        
    ~ return Time
