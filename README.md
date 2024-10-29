# mod_rng_free

A Battle Brothers mod that removes hit chances and other randomness from combat.

## Poise

This mod uses a new stat called **poise** to determine if the target of an
attack will be hit or not.

Simply put, every attack has a "poise damage" value based on its AP cost (1 for
<5 AP, 2 for >=5 AP).
If the defender's current poise is less than this value, the defender will be
hit, otherwise they will be missed and the "poise damage" will be subtracted
from their current poise.

By default characters regenerate 1 poise per turn.

Max (and starting) poise is determined like so: [max FAT after armor] / 15
rounded down.
The most max poise you can have is 6, regardless if you have more than 6*15 FAT.

All characters have recover, and recover regenerates back to 75% of starting
poise as well as the fat regen.

### Matk, Mdef, Ratk, Rdef

Since hit change is always 100% or 0%, these stats now effect the damage done by
weapons.
A new damage multiplier is calculated like (atk - def - 80) / 100 + 1 and
applied at the end of the damage calculation.

This effectively makes an 80% hit chance the "break even" point where damage is
unchanged.
Any chance below this and damage will be reduced, any above it and damage will
be increased.

### Ranged attacks

Ranged attacks will only drain poise if the targeted character is in the direct
line of fire (not covered by another bro or an obstacle).

### Strategy Notes

In a 1v1 neither party will be able to hit the other if they both regenerate 2
poise per turn.

In a 1v2 the lone party will be hit twice.

### Perk/Skill Changes

**NOT YET IMPLEMENTED!**

**Shieldwall:** Using will regenerate 3 poise.

**Dodge:** Regenerate one additional poise if faster than one of the engaged
enemies.

**Underdog:** Regenerate one additional poise for each surrounding enemy past
the first two.

**Nimble:** Removed from the game.
The benefit from light armor is more starting poise stacks.


## Installing the Mod

Every commit to this repository will generate a GitHub release, from which you can download the mod_rng_free.zip file to place in your Battle Brothers data/ directory to install the mod.

## Rejected Ideas

### Action Point Buffer

If a character is hit when they have action points remaining, the attack misses
and they lose AP equal to the AP cost of the attacking skill, as well as some
FAT.

### Fast Adaptation Everywhere

For every attacker-defender pair in the entire battle, track an "adaptation"
count, which is initially set at (attackers matk - defenders mdef) // 20.
Whenever an attacker attacks that defender, decrement this count.
If the count is then 0 or below, the attack is a hit, otherwise it is a miss.

One way to think about this is that the attacker needs to probe the target with
some missed attacks before they understand the target's movement/defenses and
can start hitting.

To the player, this count would be displayed in place of the hit chance preview
window, as long as an indicator that the next attack will hit or miss.  Also all characters that can be hit by some other living character get an indicator over them that says they are in danger.

Some thoughts about how this would change the game:

 - Initiative is more important
 - Weapons that swing more per turn are more important
 - "Breakpoints" for matk/mdef would exist that give you an extra free dodge/attack
 - This system may not work very well for ranged attacks

When shieldwalling, the character gets +2 to all "adaptation" counters to let them hold on a bit longer.  This goes up to the original max to prevent spam.


