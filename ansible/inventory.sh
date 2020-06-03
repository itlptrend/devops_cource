#!/bin/bash
dynamic_json_file=inventory.json_dinamic
if [ "$1" == "--list" ] ; then
        cat ${dynamic_json_file}
elif [ "$1" == "--host" ]; then
        echo '{"_meta": {"hostvars": {}}}'
else
        echo "{ }"
fi