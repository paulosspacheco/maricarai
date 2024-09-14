#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Linking /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-v0.9.0-Lazarus-2.2.6/mi.rtl/examples/svrhttp/svr_http_listRecords.exe
OFS=$IFS
IFS="
"
/usr/bin/ld -b elf64-x86-64 -m elf_x86_64  --dynamic-linker=/lib64/ld-linux-x86-64.so.2     -L. -o /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-v0.9.0-Lazarus-2.2.6/mi.rtl/examples/svrhttp/svr_http_listRecords.exe -T /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-v0.9.0-Lazarus-2.2.6/mi.rtl/examples/svrhttp/link31421.res -e _start
if [ $? != 0 ]; then DoExitLink /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-v0.9.0-Lazarus-2.2.6/mi.rtl/examples/svrhttp/svr_http_listRecords.exe; fi
IFS=$OFS
