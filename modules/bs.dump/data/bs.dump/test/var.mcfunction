# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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
# @dummy

await entity B5-0-0-0-2

data modify storage bs:data packtest set value {foo:"bar"}
function #bs.dump:var { var: { storage: "storage bs:data packtest", entity:"entity @s {} 0", score: ["3 bs.const", "-_- bs.const"] }}

assert chat '.*?\\{[\\s\\S]*storage: \\{[\\s\\S]*foo: \\"bar\\"[\\s\\S]*\\}[\\s\\S]*\\}'
assert chat '.*?\\{[\\s\\S]*entity: \\{ [0-9]+ entries .*? \\}[\\s\\S]*\\}'
assert chat '.*?\\{[\\s\\S]*score: \\[3, undefined\\][\\s\\S]*\\}'

data remove storage bs:data packtest
