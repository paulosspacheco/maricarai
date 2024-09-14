#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Linking /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai_fixe-3.0/mi.ui.lcl.form/examples/ph_app_br/avm/dm/test_dm
OFS=$IFS
IFS="
"
/usr/bin/ld -b elf64-x86-64 -m elf_x86_64  --dynamic-linker=/lib64/ld-linux-x86-64.so.2     -L. -o /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai_fixe-3.0/mi.ui.lcl.form/examples/ph_app_br/avm/dm/test_dm -T /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai_fixe-3.0/mi.ui.lcl.form/examples/ph_app_br/avm/dm/link7892.res -e _start
if [ $? != 0 ]; then DoExitLink /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai_fixe-3.0/mi.ui.lcl.form/examples/ph_app_br/avm/dm/test_dm; fi
IFS=$OFS
