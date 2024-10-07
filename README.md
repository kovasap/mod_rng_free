# mod_rng_free

A Battle Brothers mod that removes hit chances and other randomness from combat.

## Features

Every attack made will hit its target, UNLESS the target has some way to make the attack change from a gauranteed hit to a gauranteed miss.

If a character still has AP and Fat remaining in the round, 2 AP + 5 Fat will be used to dodge the attack.
In the future I might change the AP/Fat costs to scale off of attacker Matk and defender Mdef.

If a character is shieldwalling, they cannot be hit.

All characters also have **poise**, which is simply a count of how many times a character can dodge before they are hit.
Each character's starting and maximum poise is determined by Mdef / 10, rounded down.
Each character recovers one poise per turn.
**Poise is currently disabled!**

## Installing

Every commit to this repository will generate a GitHub release, from which you can download the mod_rng_free.zip file to place in your Battle Brothers data/ directory to install the mod.
