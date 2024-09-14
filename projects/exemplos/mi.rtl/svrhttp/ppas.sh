#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Assembling webmodule2
/usr/bin/as --64 -o /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai/mi.rtl/examples/svrhttp/lib/x86_64-linux/webmodule2.o   /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai/mi.rtl/examples/svrhttp/lib/x86_64-linux/webmodule2.s
if [ $? != 0 ]; then DoExitAsm webmodule2; fi
rm /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai/mi.rtl/examples/svrhttp/lib/x86_64-linux/webmodule2.s
echo Assembling svr_http_listrecords
/usr/bin/as --64 -o /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai/mi.rtl/examples/svrhttp/lib/x86_64-linux/svr_http_listrecords.o   /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai/mi.rtl/examples/svrhttp/lib/x86_64-linux/svr_http_listrecords.s
if [ $? != 0 ]; then DoExitAsm svr_http_listrecords; fi
rm /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai/mi.rtl/examples/svrhttp/lib/x86_64-linux/svr_http_listrecords.s
echo Linking /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai/mi.rtl/examples/svrhttp/svr_http_listRecords.exe
OFS=$IFS
IFS="
"
/usr/bin/ld.bfd -b elf64-x86-64 -m elf_x86_64  --dynamic-linker=/lib64/ld-linux-x86-64.so.2       -L. -o /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai/mi.rtl/examples/svrhttp/svr_http_listRecords.exe -T /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai/mi.rtl/examples/svrhttp/link68872.res -e _start
if [ $? != 0 ]; then DoExitLink /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai/mi.rtl/examples/svrhttp/svr_http_listRecords.exe; fi
IFS=$OFS
