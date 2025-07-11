# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
# ------------------------------------------------------------------------------------------------------------

# A big thanks to @majoras16 and @Draco18s on Minecraft Forge (https://forums.minecraftforge.net/topic/29244-1710-detect-if-player-is-looking-at-the-sun/) for giving me pointers on how to implement this.

# --- Original algorithm, from the Minecraft source code ---

# double d = MathHelper.fractionalPart((double)this.fixedTime.orElse(time) / 24000.0 - 0.25);
# double e = 0.5 - Math.cos(d * Math.PI) / 2.0;
# float r = (float)(d * 2.0 + e) / 3.0f;
# r = r * ((float) Math.PI * 2);

# Then, to convert to degrees:

# float result = (r * 180 / Math.PI) % 180) - 90;

# The following code is the implementation of the above algorithm, adapted to the Minecraft scoreboard system.
# Since we cannot use floatting point numbers, we use integers and scale them by 1000 to keep precision.

# ----------------------------------------------------------

# Get initial time values
execute store result score #d bs.ctx run time query day
execute store result score #t bs.ctx run time query daytime

# --- Block 1: Calculate d (scale 1000) ---
scoreboard players operation #d bs.ctx *= 24000 bs.const
scoreboard players operation #d bs.ctx += #t bs.ctx
scoreboard players operation #d bs.ctx *= 1000 bs.const
scoreboard players operation #d bs.ctx /= 24000 bs.const
scoreboard players operation #d bs.ctx -= 250 bs.const

# --- Block 2: Fractional part of d ---
# This is equivalent to fractionalPart(d) for a scale of 1000
scoreboard players operation #d bs.ctx %= 1000 bs.const

# --- Block 3: Calculate e ---
scoreboard players operation #e bs.ctx = #d bs.ctx
# In the original algorithm, d is multiplied by PI to obtain the angle in radians for the cosine function.
# The cosine function from Bookshelf expects the angle in degrees, so we need to convert it to degrees instead of radians.
scoreboard players operation #e bs.ctx *= 180 bs.const

# Call cosine function with precision constraint
# Prepare input: convert from scale 10³ to 10², since this is the precision of the Bookshelf's cosine function
scoreboard players operation $math.cos.x bs.in = #e bs.ctx
scoreboard players operation $math.cos.x bs.in /= 10 bs.const
# Call the function
function #bs.math:cos
# Get output (already at scale 10³ according to the Bookshelf's cosine documentation)
scoreboard players operation #e bs.ctx = $math.cos bs.out

scoreboard players operation #e bs.ctx /= 2 bs.const
scoreboard players operation #c bs.ctx = #e bs.ctx
scoreboard players operation #e bs.ctx = 500 bs.const
scoreboard players operation #e bs.ctx -= #c bs.ctx

# --- Block 4: Calculate intermediate result ---
scoreboard players operation $environment.get_sun_angle bs.out = #d bs.ctx
scoreboard players operation $environment.get_sun_angle bs.out *= 2 bs.const
scoreboard players operation $environment.get_sun_angle bs.out += #e bs.ctx
scoreboard players operation $environment.get_sun_angle bs.out /= 3 bs.const

# --- Block 5: Final transformations ---
# Simplify '...× PI × 2 × 180 / PI' to '...× 360'
scoreboard players operation $environment.get_sun_angle bs.out *= 360 bs.const
# Modulo 180 (at scale 1000)
scoreboard players operation $environment.get_sun_angle bs.out %= 180000 bs.const
# Subtract 90 (at scale 1000)
scoreboard players operation $environment.get_sun_angle bs.out -= 90000 bs.const

execute unless score #t bs.ctx matches 6000..18000 run scoreboard players operation $environment.get_sun_angle bs.out *= -1 bs.const

# --- Return value in degrees, at scale 1000 ---
return run scoreboard players get $environment.get_sun_angle bs.out
