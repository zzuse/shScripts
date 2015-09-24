awk '{for(i=0;i<5;i++){a[i]=a[i+1];}}{a[5]=$0;} /retry loadData profile/{printf "%s %s",a[0], a[5];getline; getline; print $0, "\n"}' $1 | awk '{print $3, $4, $7, substr($23, 31, 9)}'

awk '{print $2}' Gp.txt |awk '{if(a<1.0){print a;}}{a=$0;}'

echo a|awk '{print 1.0/(4.0*3.14)}'

awk '{print substr($0,5,5),int(substr($0,305,10))/1024,int(substr($0,316,10))/(int(substr($0,305,10))/1024)}' *old*r1.diff|sort

ps -ef|grep sms|grep devrt03 |grep -v grep |awk '{print $2}'|xargs kill
ps -ef|grep Prep|grep -v grep|grep zhangz|awk '{print $2}'|xargs kill
ps -elf |grep Prep|grep -v grep |grep devrt03|awk '{print $10}'
ps -ef |grep Prep|grep -v grep |grep devrt03|awk '{print $2}'|xargs kill

awk -F ';' '{print $1,$7,$54,NF}'
awk -F ';' '{print $29}' npdata|sort |uniq -c

grep expr prep_12.27_20150331.sh | awk -F '-e' '{print $2}'|awk -F ' ' '{print $1}'
cat origin100.txt | awk -F '0' '{print NF-1}' | awk '{s+=$1} END {print s}'
awk -F ';' '{print NF}'
awk -F '\n' '{if(length($0)!=295)print $0}' AMSC1.200712283741.FT.cdr

ps -ef|grep Prep|grep -v grep|grep acct|awk '{print $2}'|xargs kill
awk 'BEGIN{sum=0}{sum=sum+int(substr($0,218,6))}END{print sum}'
grep -i MODIFYMO tc_dd9999.c | awk -F '/' '{print $3}' | sed -e 's/");//g'

more shape100.txt  | awk '{print $1}' | sort | uniq -c | sort -rn
awk -F " " '{for(i=1;i<=NF;++i) {++a[$i]}next}END{for (j=0;j<=40;++j)print a[j]}' shapefactor100.txt
