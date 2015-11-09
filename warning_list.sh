#!/bin/sh
#set -x
#base_path="$(cd $(dirname $0) && pwd)/"
base_path="$(dirname $0)/"
echo "base_path:$base_path"

#iap_conf="$root_path""iap.conf"
#content of module.conf 
#new_files=(
#smd_ssh_sl
#dbaccess
#)#new_files
confFile="$HOME/"module.conf
if [ -f "$confFile" ]
then
    module_conf="$confFile"
    echo "Using local module.conf"
else 
    module_conf="$base_path""module.conf"
    echo "No local module.conf, use default"
fi 
temp="$base_path""temp.txt"

#new files list
declare -a new_files_list


#//////////////////////////////////////////////////////////
#Description: read configuration from file 
#	1) get the section begin line number and end line number
#	2) write the section content to the temp file
#	3) read the temp files by one line and set the line to
#	   the target array. 
#	       
# $1 the begin regular expression
# $2 the end regular expression
# $3 the target array which store the configuration data.
#//////////////////////////////////////////////////////////
read_conf()
{
declare begin_line
declare end_line
i=-1

#read conf file
begin_line=`grep -n -w $1 $module_conf | awk -F: '{ print $1}'`
if [ $? -ne 0 ]
then
	echo "can not find regular expression:"$1
	exit 1
fi
end_line=`grep -n -w $2 $module_conf | awk -F: '{ print $1}'`
if [ $? -ne 0 ]
then
	echo "can not find regular expression:"$2
	exit 1
fi

begin_line=`expr $begin_line + 1`
end_line=`expr $end_line - 1`

#empty
if [ $end_line -lt $begin_line ]
then
	echo "No files between regular expression : $1 $2"
	return 0
fi
rm -rf $temp
sed -n $begin_line","$end_line"w "$temp $module_conf 
if [ $? -ne 0 ]
then
	echo "save temp content error:"$temp"iap conf:"$module_conf
	exit 1
fi
while read line
do
        i=`expr $i + 1`	
	eval "$3[$i]=$line"
done < $temp 
rm -rf $temp
}
read_all_conf()
{
#read new_files
read_conf "new_files=(" 	")#new_files"	"new_files_list"
num_new_files=${#new_files_list[*]}
#echo ${new_files_list[@]}
echo "checking the modules: ${new_files_list[@]}"
}

usage ()
{

    if ( [ $nbparam -eq 0 ] ) then
        echo "Must input one or two mandotary parameter: the waring draft data file name"
            echo "1.Usage for this tool: `basename $0` Rbase_raw" 
            echo "2.Usage for this tool: `basename $0` Rbase_raw Branch_raw" 
            echo "note:\"Rbase_raw\",\"Branch_raw\" is the build result log file" 
            exit -1
    fi
    if ( [ $nbparam -gt 2 ] ) then
        echo "Must input one or two mandotary parameter: the waring draft data file name"
            echo "1.Usage for this tool: `basename $0` Rbase_raw" 
            echo "2.Usage for this tool: `basename $0` Rbase_raw Branch_raw" 
            echo "note:\"Rbase_raw\",\"Branch_raw\" is the build result log file" 
            exit -1
    fi


}
loopModule()
{
#loop the conf module to list waring according module
num=${#new_files_list[*]}
if [ $num -gt 0 ]
then
    i=0
    while [ $i -lt $num ]
    do
        #copy all the module warnings
        #echo "checking the modules: ${new_files_list[$i]}"
        #sed -n -e "/${new_files_list[$i]}/p" R4.2_warning_list.log > temp_$i.log
        sed -n -e "/${new_files_list[$i]}/p" $1 > temp_$i.log
##step6 replace warning:  to TAB
##sed -n -e 's/warning:/\t/gp' temp3_$i > R4.2_${new_files_list[$i]}_warning_list.log
##sed -n -e 's/warning:/\t/gp' temp3_$i > result_tmp_$i.log
        #replace warning:  to TAB
        sort temp_$i.log -o temp_$i.log
        sed -i "s/^/\t&/g" temp_$i.log 

        #count the warning num based on same files
        cat temp_$i.log | uniq -c > result_${new_files_list[$i]}.$1

        #delete the space in the front of sentence
        sed -i "s/^ \+//g" result_${new_files_list[$i]}.$1 
        #replace warning with tab
        sed -i -n -e 's/ warning: /\t/gp' result_${new_files_list[$i]}.$1
        #add module name in front of lines
        sed -i "s/^/${new_files_list[$i]}\t&/g" result_${new_files_list[$i]}.$1
##sed -i "s/^/${new_files_list[$i]}\t&/g" result_${new_files_list[$i]}.log 
##sed -i 's/\s\+/ /g'  result_$i.log
##sed -i "s/ /\t/g" result_$i.log
        cat result_${new_files_list[$i]}.$1 >> result_total.$1
        i=`expr $i + 1`
    done
fi
}
printResultbase()
{
echo  "*************************************"
echo  "*************Success*****************"
echo  "*************************************"
echo  "Warning totally number is $warning_total"
echo  "Warning source number is $warning_sourcetotal"
echo  "Warning details for modules are located in result_xxx.log"
echo  "Warning details for all selected modules is located in result_total.log"
}
printResultdiff()
{
echo  "*************************************"
echo  "*************Success*****************"
echo  "*************************************"
echo  "Warning plus totally number is $warning_plus_all"
echo  "Warning minus totally number is $warning_minus_all"
echo  "Warning change details for modules are located in result_xxx.log"
echo  "Warning details for all selected modules is located in xxxWarning_plus.log or xxxWarning_minus.log"
}

###########################
######    main   #########
###########################

##read configuration
nbparam=$#
usage
echo  "========begin read all configuraiton from module.conf=================="
read_all_conf
if [ $? -ne 0 ]
then
        echo "read all conf error!"
        exit 1
fi

if  [ $nbparam -eq 1 ]
then
#copy all the warnings from raw data to R4.C_warning_list.log
sed -n -e '/warning:/p' $1 > temp1
##step2 add \n before every /vob--- modified not used
##sed -e 's/\/vob/\n\/vob/gp'   temp1  >  temp2

#add \n before every lines
sed -e 's/^/\n&/g'   temp1  >  temp2

#remove all blank lines
sed '/^$/d'  temp2 > Rbase_warning_list.log

#sort and delete the same lines to get the real warnings:
sort Rbase_warning_list.log -o Rbase_warning_list_uniq.tmp
cat Rbase_warning_list_uniq.tmp | uniq > Rbase_warning_list_uniq.log 
fi

if [ $nbparam -eq 2 ]
then
#copy all the warnings from raw data to R4.C_warning_list.log
sed -n -e '/warning:/p' $1 > temp1
sed -n -e '/warning:/p' $2 > temp11
##step2 add \n before every /vob--- modified not used
##sed -e 's/\/vob/\n\/vob/gp'   temp1  >  temp2

#add \n before every lines
sed -e 's/^/\n&/g'   temp1  >  temp2
sed -e 's/^/\n&/g'   temp11  >  temp22

#remove all blank lines
sed '/^$/d'  temp2 > Rbase_warning_list.log
sed '/^$/d'  temp22 > Rbranch_warning_list.log

#sort and delete the same lines to get the real warnings:
sort Rbase_warning_list.log -o Rbase_warning_list_uniq.tmp
sort Rbranch_warning_list.log -o Rbranch_warning_list_uniq.tmp
cat Rbase_warning_list_uniq.tmp | uniq > Rbase_warning_list_uniq.log 
cat Rbranch_warning_list_uniq.tmp | uniq > Rbranch_warning_list_uniq.log 
diff -wdbBU0 Rbase_warning_list_uniq.log Rbranch_warning_list_uniq.log | sed '/^[-+]$/d' > WarningWave.log
awk -F: '/^-/' WarningWave.log > Warning_minus.log
awk -F: '/^+/' WarningWave.log > Warning_plus.log
fi

#filter by module configured
#loopModule "Rbase_warning_list.log"
rm -rf result_total*
if  [ $nbparam -eq 1 ]
then
    loopModule "Rbase_warning_list.log"
fi
if  [ $nbparam -eq 2 ]
then
    loopModule "Warning_plus.log"
    loopModule "Warning_minus.log"
fi
#count the number of warning
warning_total=`wc -l Rbase_warning_list.log| awk '{print $1}'`
warning_sourcetotal=`wc -l Rbase_warning_list_uniq.log| awk '{print $1}'`
#warning_modules=`wc -l result_total.Rbase_warning_list.log| awk '{print $1}'`
##warning_plus_all=`wc -l Warning_plus.log| awk '{print $1}'`
##warning_minus_all=`wc -l Warning_minus.log| awk '{print $1}'`
rm -rf *tmp*
rm -rf temp*

if  [ $nbparam -eq 1 ]
then
printResultbase
fi
if  [ $nbparam -eq 2 ]
then
warning_plus_all=`wc -l Warning_plus.log| awk '{print $1}'`
warning_minus_all=`wc -l Warning_minus.log| awk '{print $1}'`
printResultdiff
fi
