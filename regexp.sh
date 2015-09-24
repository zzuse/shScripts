
%^(?+^)^p         '^1'^p
^([~ ]^) +^(*^)^p    '^1','^2'^p
([\w ]+).+  \1

:%s/four/4/g
%s/^v^m//g
2,13 s /^/#/g

cat de.log |tr -c '[:alnum:]' '[\n*]' |sort -iu |grep -v '^[0-9]*$'
去后缀 cut -d . -f1

perl -pi -e 's|192.130.15.4|192.130.12.38|g' `find . -name "Root"`

sed -i 's/172.25.126.10/172.25.126.50/g' *.xml
sed -i 's/172.25.126.10/172.25.126.50/g' *.log
cat a.txt | xargs -i cat "cs/{}" > mysqldiff.txt
find . -name "*[l|x][o|m][g|l]"  |xargs -i sed -i 's/172.25.126.10/172.25.126.50/g' {}
ssh root@vm50 cat /tmp/pup.config | diff ./pup.config_0416 -
sed 's/\(.*\)key\(.*\)values\(.*\)/\2/g' fmtnewsmslog
