import os

concat_MPL2 = '''# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/Gunivers/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
#
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/string.html#concat
# ------------------------------------------------------------------------------------------------------------

'''

size =100
for i in range(size):
    with open(str(i+1)+'.mcfunction', 'w') as f :
        string1 = ''
        for j in range(i+1):
            string1 += 'data modify storage bs:ctx _.s.'+str(j+2)+' set from storage bs:ctx _.l[-1]\ndata remove storage bs:ctx _.l[-1]\n'
        string1 += "function bs.string:concat/combine/"+str(i+1)+"c with storage bs:ctx _.s"
        f.write(concat_MPL2+string1)
    with open(str(i+1)+'c.mcfunction', 'w') as f :
        stringList = []
        for j in range(i+1,-1,-1):
            stringList.append("$("+str(j+1)+")")
        string2 = ''.join(stringList)
        f.write(concat_MPL2+'$data modify storage bs:ctx _.s.1 set value "'+string2+'"')