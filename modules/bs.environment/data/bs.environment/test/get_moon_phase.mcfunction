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

# Test day 0 - full moon
time set 0t
function #bs.environment:get_moon_phase
assert data storage bs:out environment{get_moon_phase:"full_moon"}

# Test day 1 - waning gibbous
time set 24000t
function #bs.environment:get_moon_phase
assert data storage bs:out environment{get_moon_phase:"waning_gibbous"}

# Test day 2 - third quarter
time set 48000t
function #bs.environment:get_moon_phase
assert data storage bs:out environment{get_moon_phase:"third_quarter"}

# Test day 3 - waning crescent
time set 72000t
function #bs.environment:get_moon_phase
assert data storage bs:out environment{get_moon_phase:"waning_crescent"}

# Test day 4 - new moon
time set 96000t
function #bs.environment:get_moon_phase
assert data storage bs:out environment{get_moon_phase:"new_moon"}

# Test day 5 - waxing crescent
time set 120000t
function #bs.environment:get_moon_phase
assert data storage bs:out environment{get_moon_phase:"waxing_crescent"}

# Test day 6 - first quarter
time set 144000t
function #bs.environment:get_moon_phase
assert data storage bs:out environment{get_moon_phase:"first_quarter"}

# Test day 7 - waxing gibbous
time set 168000t
function #bs.environment:get_moon_phase
assert data storage bs:out environment{get_moon_phase:"waxing_gibbous"}

# Test day 8 - full moon again (cycle repeats)
time set 192000t
function #bs.environment:get_moon_phase
assert data storage bs:out environment{get_moon_phase:"full_moon"}
