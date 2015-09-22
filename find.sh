find . -name "*.h" -exec grep -i audi_stat_rate {} \
find . \( -type d ! -name . -prune \) -o \( -mtime -1 -print \)
find . \( -type d ! -name . -prune \) -o \( -type f  \)
find . \( -type d ! -name . -prune \) -o \( -name "*"  \)

year_before = itoa(atoi(substr($NOW,0,8))-20000);
year_after =  itoa(atoi(substr($NOW,0,8))+20000);
mkdir("a",00777);

find . -mtime -4 -a -mtime +3  -print
find . -type f|xargs wc -l|grep total
