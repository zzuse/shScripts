
for file in *
do a=`echo $file |cut -c 1-22`
    mv $file $a
done

for file in `cat filelist`^Jdo^Jecho $file^Jdiff $file ~/zhangz/scout/src/.^Jdone  >x

for file in `cat filelist2`^Jdo ^Jecho $file|cut -d . -f1^J^Jnewfile=`echo $file|cut -d . -f1`".h"^Jdiff ../include/$newfile ~/zhangz/scout/include/.^J^Jecho $newfile $file^Jdiff $file ~/zhangz/scout/src/.^Jdone >x
