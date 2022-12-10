if [ $# -ne 3 ]; then
echo "The script needs three directories as input to run"
exit 1
fi

directory1=$1
directory2=$2
directory3=$3

commonFiles=()
commonSize=0

if [ ! -d $directory1 ]; then
echo "The first input is not a directory"
exit 2
fi

if [ ! -d $directory2 ]; then
echo "The second input is not a directory"
exit 3
fi

if [ ! -d $directory3 ]; then
echo "The third input is not a directory"
exit 4
fi

for file1 in $directory1/*
do
if [ ! -f "$directory2/${file1##*/}" ]; then
echo "$file1 isn't in $directory2 and it's size is $(wc -c $file1 | cut -d " " -f 1)"
else
commonFiles+=(${file1##*/})
fileSize=$(wc -c $file1 | cut -d " " -f 1)
commonSize=$(($commonSize + $fileSize))
fi
done

for file2 in $directory2/*
do
if [ ! -f "$directory1/${file2##*/}" ]; then
echo "$file2 isn't in $directory1 and it's size is $(wc -c $file2 | cut -d " " -f 1)"
fi
done

echo "The common files between the two directories are: ${commonFiles[*]}"
echo "The size of the common files between the two directories is: $commonSize"

for file in ${commonFiles[@]}
do
mv $directory1/$file $directory3
rm $directory2/$file
ln $directory3/$file $directory1/link-$file
ln $directory3/$file $directory2/link-$file
echo "moved and make link for $file"
done
