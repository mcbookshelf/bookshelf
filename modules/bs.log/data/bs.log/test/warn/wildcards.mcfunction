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

tag @s add bs.foo.log.bar._
function #bs.log:warn { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Level wildcard warn log message"' }
assert chat "Level wildcard warn log message"
tag @s remove bs.foo.log.bar._

tag @s add bs.foo.log._.warn
function #bs.log:warn { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Tag wildcard warn log message"' }
assert chat "Tag wildcard warn log message"
tag @s remove bs.foo.log._.warn

tag @s add bs.foo.log._._
function #bs.log:warn { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Tag and level wildcards warn log message"' }
assert chat "Tag and level wildcards warn log message"
tag @s remove bs.foo.log._._

tag @s add _.log._._
function #bs.log:warn { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"All wildcards warn log message"' }
assert chat "All wildcards warn log message"
tag @s remove _.log._._
