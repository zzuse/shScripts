# shScripts
my shell scripts
要安装 .deb 套件包时
sudo dpkg -i package_file.deb
要反安装 .deb 套件包时
sudo dpkg -r package_name
无限制core文件ulimit -S -c unlimited > /dev/null 2>&1
nm -B -BCpg charge_shell.o charge_element.o element_basic.o rate_one.o | awk '{ if ((($2 == "T") || ($2 == "D") || ($2 == "B")) && (substr($3,1,1) != ".")) { print $3 } }' | sort -u > a.exp; xlC_r -bE:a.exp -G -bM:SRE -bnoentry -qmkshrobj -qtempinc -qlonglong -bdynamic -berok -L/unibss/devusers/devrt03/aioss/center/lib -L/unibss/devusers/devrt03/aioss/lib -L/opt/freeware/ACE-5.6.6/lib -lACE -lbaseutil -lbasecomm -lbaseprep -lbasepara -lbaserate -lbaseproc -lbaseanaly -L/oravl01/oracle/10.2.0.4/lib32 -L/oravl01/oracle/10.2.0.4/lib -lclntsh -lclient10  charge_shell.o  charge_element.o element_basic.o  rate_one.o -qlonglong  -DWORDS_BIGENDIAN -qmaxmem=-1 -o librateone.so
nm -C libsmssend.so
xlC_r  -P
看rpm包内容:rpm -q -filesbypkg -p kernel-debuginfo-common-x86_64-2.6.32-358.el6.x86_64.rpm
readelf -r -S myNew | tee 3
objdump  -a -x -t -d myNew | tee 2
cp -d files /var/copylinktohere/
dos2unix ResponseBer.trim
rawDataParser_zz.py ResponseBer.trim
xxd -r -p ResponseBer.trim ResponseBer.bin
