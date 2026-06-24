#!/bin/bash
# CPU usage as delta between two /proc/stat samples (matches top/btop behaviour)
read -r _ u1 n1 s1 i1 w1 r1 x1 _ < /proc/stat
sleep 0.3
read -r _ u2 n2 s2 i2 w2 r2 x2 _ < /proc/stat

total1=$((u1+n1+s1+i1+w1+r1+x1))
total2=$((u2+n2+s2+i2+w2+r2+x2))
diff_total=$((total2-total1))
diff_idle=$((i2-i1))

[ "$diff_total" -eq 0 ] && echo 0 && exit
echo $(( 100 * (diff_total - diff_idle) / diff_total ))
