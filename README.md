# mod_rng_free

A Battle Brothers mod that removes hit chances and other randomness from combat.

## Features

### Poise

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

NOT YET IMPLEMENTED: using "shieldwall" will regenerate 4 poise.

#### Poise Examples

In a 1v1 neither party will be able to hit the other if they both regenerate 2
poise per turn.


## Installing

Every commit to this repository will generate a GitHub release, from which you can download the mod_rng_free.zip file to place in your Battle Brothers data/ directory to install the mod.
