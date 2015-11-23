find . -name "*.cpp" -print | xargs grep $1
find . -name "*.cc" -print | xargs grep $1
find . -name "*.h" -print | xargs grep $1

