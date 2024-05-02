# INFO ------------------------------------------------------------------------
# Copyright © 2024 Gunivers Community.

# Authors: Aksiome, KubbyDev
# Contributors:

# Version: 2.1
# Created: ??/??/2018 (1.13)
# Last modification: 29/01/2024 (1.20.4)

# Documentation: https://bookshelf.docs.gunivers.net/en/latest/modules/math.html#logarithm
# Dependencies:
# Note:

# CODE ------------------------------------------------------------------------

data modify storage bs:ctx x set from storage bs:in math.log10.x
function bs.math:log2/run
execute store result storage bs:out math.log10 float .000000059604644775390625 run data get storage bs:ctx x 5050445.259733675979077816009521484375
