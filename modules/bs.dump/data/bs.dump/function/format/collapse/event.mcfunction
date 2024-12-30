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

data modify entity B5-0-0-0-2 text set value '[{"text":" ","color":"#999999"},{"score":{"name":"#dump.count","objective":"bs.data"}},{"text":" entries "}]'
data modify storage bs:out dump append from entity B5-0-0-0-2 text
$data modify storage bs:out dump append value "[\"\",{\"text\":\"⌊📄⌉\",\"color\":\"#cccccc\",\"bold\":true,\"clickEvent\":{\"action\":\"copy_to_clipboard\",\"value\":\"$(var)\"},\"hoverEvent\":{\"action\":\"show_text\",\"contents\":\"Click to copy\"}},\" \",{\"text\":\"⌊⬇⌉\",\"color\":\"#cccccc\",\"bold\":true,\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/function bs.dump:expand {var:$(var)}\"},\"hoverEvent\":{\"action\":\"show_text\",\"contents\":\"Click to expand\"}},\" \"]"
