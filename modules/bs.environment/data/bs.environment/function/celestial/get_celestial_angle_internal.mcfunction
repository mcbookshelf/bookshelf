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

# Inputs:
# - #d: The day
# - #t: The time of day
# - macro scale: scale of the output value

# --- Block 1: Calculate d (scale 1000) ---
scoreboard players operation $environment.celestial_angle.day bs.in *= 24000 bs.const
scoreboard players operation $environment.celestial_angle.day bs.in += $environment.celestial_angle.daytime bs.in
scoreboard players operation $environment.celestial_angle.day bs.in *= 1000 bs.const
scoreboard players operation $environment.celestial_angle.day bs.in /= 24000 bs.const
scoreboard players operation $environment.celestial_angle.day bs.in -= 250 bs.const

# --- Block 2: Fractional part of d ---
# This is equivalent to fractionalPart(d) for a scale of 1000
scoreboard players operation $environment.celestial_angle.day bs.in %= 1000 bs.const

# --- Block 3: Calculate e ---
scoreboard players operation #e bs.ctx = $environment.celestial_angle.day bs.in
# In the original algorithm, d is multiplied by PI to obtain the angle in radians for the cosine function.
# The cosine function from Bookshelf expects the angle in degrees, so we need to convert it to degrees instead of radians.
scoreboard players operation #e bs.ctx *= 180 bs.const

# Call cosine function with precision constraint
# Prepare input: convert from scale 10³ to 10², since this is the precision of the Bookshelf's cosine function
scoreboard players operation #e bs.ctx /= 10 bs.const
# Call the function, output is already at scale 10³ according to the Bookshelf's cosine documentation
function bs.environment:celestial/cos

scoreboard players operation #e bs.ctx /= 2 bs.const
scoreboard players operation #c bs.ctx = #e bs.ctx
scoreboard players operation #e bs.ctx = 500 bs.const
scoreboard players operation #e bs.ctx -= #c bs.ctx

# --- Block 4: Calculate intermediate result ---
scoreboard players operation #r bs.ctx = $environment.celestial_angle.day bs.in
scoreboard players operation #r bs.ctx *= 2 bs.const
scoreboard players operation #r bs.ctx += #e bs.ctx
scoreboard players operation #r bs.ctx /= 3 bs.const

# --- Block 5: Final transformations ---
# Simplify '...× PI × 2 × 180 / PI' to '...× 360'
scoreboard players operation #r bs.ctx *= 360 bs.const
# Modulo 180 (at scale 1000)
scoreboard players operation #r bs.ctx %= 180000 bs.const
# Subtract 90 (at scale 1000)
scoreboard players operation #r bs.ctx -= 90000 bs.const

execute unless score $environment.celestial_angle.daytime bs.in matches 6000..17999 run scoreboard players operation #r bs.ctx *= -1 bs.const
