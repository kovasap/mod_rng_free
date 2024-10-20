# mod_rng_free

A Battle Brothers mod that removes hit chances and other randomness from combat.


## Alternate Idea: Fast Adaptation Everywhere

**NOT YET IMPLEMENTED!**

For every attacker-defender pair in the entire battle, track an "adaptation"
count, which is initially set at (attackers matk - defenders mdef) // 20.
Whenever an attacker attacks that defender, decrement this count.
If the count is then 0 or below, the attack is a hit, otherwise it is a miss.

One way to think about this is that the attacker needs to probe the target with
some missed attacks before they understand the target's movement/defenses and
can start hitting.

To the player, this count would be displayed in place of the hit chance preview
window, as long as an indicator that the next attack will hit or miss.

Some thoughts about how this would change the game:

 - Initiative is more important
 - Weapons that swing more per turn are more important
 - "Breakpoints" for matk/mdef would exist that give you an extra free dodge/attack
 - This system may not work very well for ranged attacks



## Poise

This mod uses a new stat called **poise** to determine if the target of an
attack will be hit or not.

Simply put, every attack has a "poise damage" value based on its AP cost (1 for
<5 AP, 2 for >=5 AP).
If the defender's current poise is less than this value, the defender will be
hit, otherwise they will be missed and the "poise damage" will be subtracted
from their current poise.

By default characters regenerate 2 poise per turn.

Max (and starting) poise is determined like so: MaxPoise = (Mdef + Rdef) / 10
rounded down.

### Strategy Notes

In a 1v1 neither party will be able to hit the other if they both regenerate 2
poise per turn.

In a 1v2 the lone party will be hit twice.

### Perk/Skill Changes

**NOT YET IMPLEMENTED!**

**Shieldwall:** Using will regenerate 2 poise plus 2 for every adjacent brother.

**Dodge:** Regenerate one additional poise if faster than one of the engaged
enemies.

**Underdog:** Regenerate one additional poise for each surrounding enemy past
the first two.


## Installing the Mod

Every commit to this repository will generate a GitHub release, from which you can download the mod_rng_free.zip file to place in your Battle Brothers data/ directory to install the mod.
