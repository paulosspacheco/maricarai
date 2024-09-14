#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Linking /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.web/lcl/cliente/lib/x86_64-linux/mi.web.form.cliente.or
OFS=$IFS
IFS="
"
/home/paulosspacheco/v/Lazarus/fpcupdeluxe/fpc/bin/x86_64-linux/fpcres -o /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.web/lcl/cliente/lib/x86_64-linux/mi.web.form.cliente.or -a x86_64 -of elf  '@/home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.web/lcl/cliente/lib/x86_64-linux/mi.web.form.cliente.reslst'
if [ $? != 0 ]; then DoExitLink /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.web/lcl/cliente/lib/x86_64-linux/mi.web.form.cliente.or; fi
IFS=$OFS
echo Linking /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.web/lcl/cliente/mi.web.form.cliente.form
OFS=$IFS
IFS="
"
/usr/bin/ld -b elf64-x86-64 -m elf_x86_64  --dynamic-linker=/lib64/ld-linux-x86-64.so.2     -L. -o /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.web/lcl/cliente/mi.web.form.cliente.form -T /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.web/lcl/cliente/link19738.res -e _start
if [ $? != 0 ]; then DoExitLink /home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.web/lcl/cliente/mi.web.form.cliente.form; fi
IFS=$OFS
