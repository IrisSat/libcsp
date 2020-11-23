#!/bin/bash

project_path=$1

echo "Getting inclue files from $project_path"

INCLUDES="$project_path/FreeRTOS,"
INCLUDES+="$project_path/FreeRTOS/FreeRTOS-Source,"
INCLUDES+="$project_path/FreeRTOS/FreeRTOS-Source/include,"
INCLUDES+="$project_path/FreeRTOS/FreeRTOS-Source/portable,"
INCLUDES+="$project_path/FreeRTOS/FreeRTOS-Source/portable/GCC/ARM_CM3,"

echo $INCLUDES

CFLAGS=""
count=0
for var in $@
do
        if [ $count -ne 0 ]
        then
            echo "$var"
            CFLAGS+="$var "
        fi
        count+=1
done

echo $CFLAGS

python3 waf configure --toolchain=arm-none-eabi- --enable-if-can --with-os=freertos --cflags "$CFLAGS" --includes="$INCLUDES"

python3 waf build

rm "$project_path/Libraries/CSP/libcsp.a"
cp build/libcsp.a "$project_path/Libraries/CSP/libcsp.a"
