:: before_coding.bat
D:
cd D:\sdm\code
echo Starting 7unzip tgz...
set ftpfilename=autoftp.cfg
echo open 135.252.170.223>"%ftpfilename%"
echo zhangzhen>>"%ftpfilename%"
echo zhangzhen>>"%ftpfilename%"
echo bin>>"%ftpfilename%"
echo get /local/zhangzhen/lte.tgz>>"%ftpfilename%"
echo bye>>"%ftpfilename%"
ftp -s:"%ftpfilename%"

if not exist lte.tgz (
    echo wrong...
) else (
    D:\"Program Files"\7-Zip\7z x lte.tgz -aoa
    D:\"Program Files"\7-Zip\7z x lte.tar -aoa
    dir /s /b *.c *.cc *.cpp *.cxx *.hpp *.h *.hh *.H *.C > cscope.files
    cscope -bku -i cscope.files
    D:\"Program Files"\7-Zip\7z a DOTvim.7z .vim\ .vimrc
    D:\"Program Files"\7-Zip\7z a env.7z env\ bin\ DOT* get_newest_code.sh startvnc.sh killvnc.sh
)
