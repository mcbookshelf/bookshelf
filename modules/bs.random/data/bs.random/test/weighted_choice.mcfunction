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

# The index matches the value chosen
function #bs.random:weighted_choice.in {options:[0,1,2,3,4],weights:[1,1,1,1,1]}
execute store result score #i bs.ctx run function #bs.random:weighted_choice
execute store result score #v bs.ctx run data get storage bs.random:weighted_choice out
assert score #i bs.ctx = #v bs.ctx
assert score #i bs.ctx matches 0..4

# A value of weight 0 is never chosen
function #bs.random:weighted_choice.in {options:[0,0,42,0,0,0,0],weights:[0,0,1,0,0,0,0]}
assert result 2 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:42}

# Any value can be chosen
function #bs.random:weighted_choice.in {options:[{id:"minecraft:stone"},"text"],weights:[1,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:{id:"minecraft:stone"}}

# The only value with a weight is chosen, whatever the size of the list
function #bs.random:weighted_choice.in {options:[100],weights:[3]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101],weights:[3,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101],weights:[0,3]}
assert result 1 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:101}
function #bs.random:weighted_choice.in {options:[100,101,102],weights:[3,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102],weights:[0,0,3]}
assert result 2 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:102}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104],weights:[3,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104],weights:[0,0,0,3,0]}
assert result 3 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:103}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104],weights:[0,0,0,0,3]}
assert result 4 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:104}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106],weights:[3,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106],weights:[0,0,0,0,3,0,0]}
assert result 4 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:104}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106],weights:[0,0,0,0,0,0,3]}
assert result 6 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:106}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112],weights:[3,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112],weights:[0,0,0,0,0,0,0,3,0,0,0,0,0]}
assert result 7 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:107}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112],weights:[0,0,0,0,0,0,0,0,0,0,0,0,3]}
assert result 12 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:112}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124],weights:[3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0]}
assert result 13 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:113}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3]}
assert result 24 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:124}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131],weights:[3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 17 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:117}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3]}
assert result 31 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:131}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132],weights:[3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 17 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:117}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3]}
assert result 32 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:132}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139],weights:[3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 21 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:121}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3]}
assert result 39 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:139}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148],weights:[3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 25 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:125}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3]}
assert result 48 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:148}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163],weights:[3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 33 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:133}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3]}
assert result 63 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:163}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164],weights:[3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 33 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:133}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3]}
assert result 64 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:164}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170],weights:[3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 36 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:136}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3]}
assert result 70 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:170}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227],weights:[3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 65 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:165}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3]}
assert result 127 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:227}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228],weights:[3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:100}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 65 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:165}
function #bs.random:weighted_choice.in {options:[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3]}
assert result 128 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:228}

# The same with long lists, built by appending them to themselves
function #bs.random:weighted_choice.in {options:[0,0,0],weights:[0,0,0]}
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.options[3] set value 7
data modify storage bs.random:weighted_choice in.weights[3] set value 3
assert result 3 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:7}
data modify storage bs.random:weighted_choice in.options[3] set value 0
data modify storage bs.random:weighted_choice in.weights[3] set value 0
data modify storage bs.random:weighted_choice in.options[101] set value 7
data modify storage bs.random:weighted_choice in.weights[101] set value 3
assert result 101 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:7}
data modify storage bs.random:weighted_choice in.options[101] set value 0
data modify storage bs.random:weighted_choice in.weights[101] set value 0
data modify storage bs.random:weighted_choice in.options[191] set value 7
data modify storage bs.random:weighted_choice in.weights[191] set value 3
assert result 191 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:7}
data modify storage bs.random:weighted_choice in.options[191] set value 0
data modify storage bs.random:weighted_choice in.weights[191] set value 0
function #bs.random:weighted_choice.in {options:[0],weights:[0]}
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.options append from storage bs.random:weighted_choice in.options[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.weights append from storage bs.random:weighted_choice in.weights[]
data modify storage bs.random:weighted_choice in.options[3] set value 7
data modify storage bs.random:weighted_choice in.weights[3] set value 3
assert result 3 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:7}
data modify storage bs.random:weighted_choice in.options[3] set value 0
data modify storage bs.random:weighted_choice in.weights[3] set value 0
data modify storage bs.random:weighted_choice in.options[133] set value 7
data modify storage bs.random:weighted_choice in.weights[133] set value 3
assert result 133 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:7}
data modify storage bs.random:weighted_choice in.options[133] set value 0
data modify storage bs.random:weighted_choice in.weights[133] set value 0
data modify storage bs.random:weighted_choice in.options[255] set value 7
data modify storage bs.random:weighted_choice in.weights[255] set value 3
assert result 255 run function #bs.random:weighted_choice
assert data storage bs.random:weighted_choice {out:7}
data modify storage bs.random:weighted_choice in.options[255] set value 0
data modify storage bs.random:weighted_choice in.weights[255] set value 0

# A value past the 256th is not read: the index is one of the first 256
data modify storage bs.random:weighted_choice in.options append value 0
data modify storage bs.random:weighted_choice in.weights append value 3
assert result 0..255 run function #bs.random:weighted_choice

# Without any weight, the index still is one of the list
function #bs.random:weighted_choice.in {options:[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39],weights:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
assert result 0..39 run function #bs.random:weighted_choice

# The index stays in the list and matches the value, with every weight set
function #bs.random:weighted_choice.in {options:[0,1,2,3,4],weights:[1,2,3,4,5]}
execute store result score #i bs.ctx run function #bs.random:weighted_choice
execute store result score #v bs.ctx run data get storage bs.random:weighted_choice out
assert score #i bs.ctx = #v bs.ctx
assert score #i bs.ctx matches 0..4
function #bs.random:weighted_choice.in {options:[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48],weights:[1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7]}
execute store result score #i bs.ctx run function #bs.random:weighted_choice
execute store result score #v bs.ctx run data get storage bs.random:weighted_choice out
assert score #i bs.ctx = #v bs.ctx
assert score #i bs.ctx matches 0..48
function #bs.random:weighted_choice.in {options:[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63],weights:[1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1]}
execute store result score #i bs.ctx run function #bs.random:weighted_choice
execute store result score #v bs.ctx run data get storage bs.random:weighted_choice out
assert score #i bs.ctx = #v bs.ctx
assert score #i bs.ctx matches 0..63
function #bs.random:weighted_choice.in {options:[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199],weights:[1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4]}
execute store result score #i bs.ctx run function #bs.random:weighted_choice
execute store result score #v bs.ctx run data get storage bs.random:weighted_choice out
assert score #i bs.ctx = #v bs.ctx
assert score #i bs.ctx matches 0..199
function #bs.random:weighted_choice.in {options:[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249],weights:[1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5]}
execute store result score #i bs.ctx run function #bs.random:weighted_choice
execute store result score #v bs.ctx run data get storage bs.random:weighted_choice out
assert score #i bs.ctx = #v bs.ctx
assert score #i bs.ctx matches 0..249
