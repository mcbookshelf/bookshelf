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

data modify entity B5-0-0-0-2 text set value [{text:" ",color:"#999999"},{score:{name:"#dump.count",objective:"bs.data"}},{text:" entries "}]
data modify storage bs:data dump.out append from entity B5-0-0-0-2 text
$data modify storage bs:data dump.out append value ["",{text:"⌊📄⌉",color:"#cccccc",bold:true,click_event:{action:"copy_to_clipboard",value:"$(value)"},hover_event:{action:"show_text",value:"Click to copy"}}," ",{text:"⌊⬇⌉",color:"#cccccc",bold:true,click_event:{action:"run_command",command:"/function bs.dump:expand {var:$(value)}"},hover_event:{action:"show_text",value:"Click to expand"}}," "]
