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

$data modify storage bs:dump output append value ["",{text:"⌊📄⌉",color:"#cccccc",bold:true,click_event:{action:"copy_to_clipboard",value:"$(var)"},hover_event:{action:"show_text",value:"Click to copy"}}," ",{text:"⌊⬇⌉",color:"#cccccc",bold:true,click_event:{action:"run_command",command:"/function bs.dump:expand {var:$(var)}"},hover_event:{action:"show_text",value:"Click to expand"}}," "]
