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
function #bs.log:info { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Level wildcard info log message"' }
assert chat "Level wildcard info log message"
tag @s remove bs.foo.log.bar._

tag @s add bs.foo.log._.info
function #bs.log:info { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Tag wildcard info log message"' }
assert chat "Tag wildcard info log message"
tag @s remove bs.foo.log._.info

tag @s add bs.foo.log._._
function #bs.log:info { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"Tag and level wildcards info log message"' }
assert chat "Tag and level wildcards info log message"
tag @s remove bs.foo.log._._

tag @s add _.log._._
function #bs.log:info { namespace: "bs.foo", path: "bs.foo:bar", tag: "bar", message: '"All wildcards info log message"' }
assert chat "All wildcards info log message"
tag @s remove _.log._._
