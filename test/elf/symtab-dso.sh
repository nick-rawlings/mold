#!/bin/bash
export LC_ALL=C
set -e
CC="${CC:-cc}"
CXX="${CXX:-c++}"
testname=$(basename "$0" .sh)
echo -n "Testing $testname ... "
cd "$(dirname "$0")"/../..
mold="$(pwd)/mold"
t=out/test/elf/$testname
mkdir -p $t

cat <<EOF | $CC -o $t/a.o -c -xc -
#include <stdio.h>
int main() {
  puts("Hello world");
}
EOF

$CC -B. -o $t/exe $t/a.o
nm $t/exe | grep -q 'U puts$'

echo OK
