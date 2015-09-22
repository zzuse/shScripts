xxd psxy | sed 's/2f6f 7074/2f75 7372/g' | xxd -r > psxy-new
xxd -p wx2mm3d_bin_500_500_500.raw > 500.txt
sed  's/ff/01/g' 500.txt > 501.txt
xxd -r -p 501.txt 500.dat
