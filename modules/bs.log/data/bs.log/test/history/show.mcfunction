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

function #bs.log:warn { namespace: "bs.foo", path: "bs.foo:bar", tag: "history", message: '"History warn log message"' }
function #bs.log:error { namespace: "bs.foo", path: "bs.foo:bar", tag: "history", message: '"History error log message"' }
assert not chat "History warn log message"
assert not chat "History error log message"

function #bs.log:history {with:{tag:"history",severity:"error"}}
assert not chat "History warn log message"
assert chat "History error log message"
