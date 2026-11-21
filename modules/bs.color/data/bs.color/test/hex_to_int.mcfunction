# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

assert result 15886907 run function #bs.color:hex_to_int.in {color:"#F26A3B"}
assert data storage bs.color:hex_to_int {out:15886907}

assert result 2803797 run function #bs.color:hex_to_int.in {color:"#2AC855"}
assert result 5839296 run function #bs.color:hex_to_int.in {color:"#5919C0"}

# A color with alpha gives an ARGB integer, lowercase or uppercase
assert result -1829606853 run function #bs.color:hex_to_int.in {color:"#F26A3B92"}
assert result 975882325 run function #bs.color:hex_to_int.in {color:"#2ac8553a"}

# The color can be read from the storage
data modify storage bs.color:hex_to_int in set value {color:"#5919C0"}
assert result 5839296 run function #bs.color:hex_to_int

# The digits of a pair can be in a different case
assert result 16711851 run function #bs.color:hex_to_int.in {color:"#Ff00aB"}
