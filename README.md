# mod_rng_free

A Battle Brothers mod that removes hit chances from combat.

## Goals

Battle brothers is a game that heavily relies on RNG in combat.
I'm not sure what the developers had in mind exactly when they choose to design the game this way,
but from my time playing I see the following effects:

 1. Combat can be very tense when you have a brother in a bad position and a single hit could kill him.
    Every dice roll feels very exciting in this situation.
 2. The game sometimes rewards the player when they make bad decisions, and sometimes punishes the player when they play perfectly.
     - This, in addition to the opacity of the game mechanics in general, artificially extends ("pads") the amount of time it takes to master the game.
       In other words, the game gives a pretty noisy feedback signal to the player.  This can be seen as a pro or a con.
 3. Perks/builds that increase effective HP (e.g. colossus) are extremely important to buffer against the worst case scenario.
 4. Matk/Mdef are extremely valuable stats.
 5. Early game can feel particularly random, and you can expect to lose many bros early on regardless of your skill level.

In reflecting on these points, I started wondering how the game would feel if combat was more deterministic.
Would it start feeling boring?  Or would it instead simply feel less frustrating?
This mod is the experiment I'm using to find out.

## Changes

All attacks have a 100% chance to hit, but their damage is scaled by what was
the hit chance.
For example, what used to be an attack with a 5% hit change is now an attack
that always hits, but for 5% damage.

This idea behind this is that the expected hits to kill is the same as vanilla,
but now it will always take the the same number of hits to kill no matter what.

This mod also adds an "action points remaining" tooltip to all enemies.
I should probably remove this, but it was useful for previous iterations of the
mod and might still be nice to have.

## Installing the Mod

Every commit to this repository will generate a GitHub release (see right sidebar for a link to the most current one), from which you can download the `mod_rng_free.zip` file to place in your Battle Brothers data/ directory (e.g. `D:\SteamLibrary\steamapps\common\Battle Brothers\data`) to install the mod.

## Rejected Ideas

### Add a fixed number of dodges to each character per turn

Simply give each character a single free dodge per turn.
This idea was partially inspired by FTL's "shield" system.
In FTL, each attack has a hit chance, but each ship has one or more shields that
will block shots 100% of the time and be used up.
This makes the RNG less extreme, as the player does not have to worry about
getting hit until the shields are down - there's little potential for
"oneshot"-ing.

### Fatigue as "Shield"

Instead of checking whether an attack hits or misses against a dice roll, each
attack type has a fatigue cost that is automatically paid to dodge the attack.
If the cost cannot be paid, the attack hits.  Some example costs could look like:

- 1-handed sword swing: 8 fatigue
- 1-handed hammer swing: 5 fatigue
- 2-handed axe swing: 14 fatigue
- bow attack: 4 fatigue
- bow "aimed shot" attack: 11 fatigue

This is similar to how a "shield" system could work in a sci-fi setting (the
      shield takes damage before the wearer, preventing injury).

Weapons would now have a new trade off to play with when defining their stats.
Battle Brothers already has weapons that are better against armor vs hp; now
some weapons (like the whip) could be the hardest to dodge and be weak at
actually doing damage.

With this system, the player would have a choice when building their brother's
   defenses to either (1) focus on light armor and have a large fatigue pool to use
for dodging, or (2) focus on heavy armor and plan to just tank more hits, or (3)
   something in the middle.

   This new fatigue sink would lead to brothers running out of fatigue and becoming
   paralyzed (or just relying on the base fatigue regeneration per turn) very
   quickly if nothing else changed.
   To fix this, attacks will no longer cost fatigue to perform.
   Instead, the player on their turn will have the option to either attack, or use
   "recover" (which all brothers will be given by default) to regenerate some
   fatigue as a defensive action.

#### Matk, Mdef, Ratk, Rdef Grant Skill Points To Fuel Skills

   Since hit change is always 100% or 0%, these stats no longer have any meaning.
   To make them relevant, so that decisions when leveling brothers are more
   interesting, these stats now grant a special resource in combat known as a
   "skill" point that is granted to a brother every turn.

   For example, if a brother has 80 Matk and 20 Mdef, then based on some yet
   undefined formula they will be granted say 3 melee attack skill points and 2
   melee defense skill points that refresh to these values every turn.
   Alternatively, these points could be also just granted once at the start of
   combat and never refresh.

   These skill points are then spent as currency to use all non-basic skills.
   For example, "shieldwall" would require a melee defense skill point to use.
   "Riposte" would require a melee attack AND melee defense skill point to use.

   This system would reward players for investing in these stats with cool new
   abilities to use.
   It would also continue to constrain the ability to spam powerful abilities, as
   fatigue does in the base game.

#### Mdef and Rdef Impact Fatigue Recovery

   Since there are not too many defensive skills, Mdef and Rdef could also affect
   the fatigue recovery of bros slightly (like the "iron lungs" trait does).

#### Skill Changes

   - **Recover**: No longer tied to a perk, and given to all brothers by default.
   - **Shieldwall**: Reduces the fatigue cost to dodge/block an attack.

#### Strategy Changes

   With getting hit being an inevitability, building "ultra tank" brothers that are
   designed to dodge 95% of attacks would no longer be possible.
   It will be more important that ever to position brothers so that one single
   brother isn't exposed to too many attacks per turn.

#### AI and Enemy Changes

   Some enemy stats (notably fatigue) may have to be tweaked to make this proposed
   design playable.

   Ideally this mod would not require changing any of the AI logic in the game.

### Poise

   This mod currently uses a new stat called **poise** to determine if the target
   of an attack will be hit or not.

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

#### Matk, Mdef, Ratk, Rdef

   Since hit change is always 100% or 0%, these stats now effect the damage done by
   weapons.
   A new damage multiplier is calculated like (atk - def - 80) / 100 + 1 and
   applied at the end of the damage calculation.

   This effectively makes an 80% hit chance the "break even" point where damage is
   unchanged.
   Any chance below this and damage will be reduced, any above it and damage will
   be increased.

#### Ranged attacks

   Ranged attacks will only drain poise if the targeted character is in the direct
   line of fire (not covered by another bro or an obstacle).

#### Strategy Notes

   In a 1v1 neither party will be able to hit the other if they both regenerate 2
   poise per turn.

   In a 1v2 the lone party will be hit twice.

#### Perk/Skill Changes

   **NOT YET IMPLEMENTED!**

   **Shieldwall:** Using will regenerate 3 poise.

   **Dodge:** Regenerate one additional poise if faster than one of the engaged
   enemies.

   **Underdog:** Regenerate one additional poise for each surrounding enemy past
   the first two.

   **Nimble:** Removed from the game.
   The benefit from light armor is more starting poise stacks.


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


