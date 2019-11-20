import os
import re
import sys

src = sys.argv[1]
asmsrc = src[:src.find(".")] + ".s"
binobj = src[:src.find(".")] + ".o"
call = "gcc -march=i386 -O3 -S -fPIC -Winline " + \
        "-finline-functions  -ffreestanding " + \
        "-o %s -m32 %s" % (asmsrc, src)
print call
print
f = os.popen(call)
f.close()

asm = open(asmsrc).readlines()
ignores = (".file", ".def")
asm_stripped = []
for line in asm:
    write = True
    for ignore in ignores:
        if ignore in line: write = False
    if write: print line.replace("\n", "")

ret = os.system("gcc -c -o %s %s" % (binobj, asmsrc))
f = os.popen("objdump -j .text -s -z  %s" % (binobj, ))
objdump = f.readlines()
f.close()

regx = re.compile("^ [0-9a-f]{4}")
regxret = ""
for line in objdump:
    if regx.match(line):
        regxret = regxret + "".join(line[:42].split()[1:])
dumphex = []
while regxret:
    dumphex.append(regxret[:2])
    regxret = regxret[2:]
print dumphex
result = ["unsigned char shellcode[] = {",]
for ch in dumphex[:-1]:
    result.append("'\\x%s', " % ch)
result.append("'\\x%s' };" % dumphex[-1:][0])
print "".join(result)
