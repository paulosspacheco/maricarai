#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Linking /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.lcl/mi.web/mi.web.lcl.client/send_request/send_request
OFS=$IFS
IFS="
"
/usr/bin/ld -b elf64-x86-64 -m elf_x86_64  --dynamic-linker=/lib64/ld-linux-x86-64.so.2     -L. -o /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.lcl/mi.web/mi.web.lcl.client/send_request/send_request -T /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.lcl/mi.web/mi.web.lcl.client/send_request/link4122.res -e _start
if [ $? != 0 ]; then DoExitLink /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.lcl/mi.web/mi.web.lcl.client/send_request/send_request; fi
IFS=$OFS
