# mod_rng_free

A Battle Brothers mod that removes hit chances and other randomness from combat.

## Features

Every attack made will hit its target, UNLESS the target has some way to make the attack change from a guaranteed hit to a guaranteed miss.

If a character still has AP and Fat remaining in the round, <the attack cost> AP + 5 Fat will be used to dodge the attack.

If a character is shieldwalling, they cannot be hit.

I may change it so that Melee and Ranged Skill scale damage, right now they do nothing.

**Poise is currently disabled!**
All characters also have **poise**, which is simply a count of how many times a character can dodge before they are hit.

 - Each character's starting and maximum poise is determined by Mdef.
 - Each character recovers one poise per turn.
 - Shields give extra poise.
 - All characters can use a 9AP "defensive stance" skill to gain 3 poise.

## Installing

Every commit to this repository will generate a GitHub release, from which you can download the mod_rng_free.zip file to place in your Battle Brothers data/ directory to install the mod.
