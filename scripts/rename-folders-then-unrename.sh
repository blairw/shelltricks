# Purpose - Append an arbitrary UUID to every folder name and then remove it.
#   This forces a directory modtime change.
#   It's a hack to make FSNotes respect alphabetical sort inside subfolders.

# Caveat - There must be no spacebars in the path to the folder.
#   You might consider `ln -s` symlinking the folder somewhere if you
#   need to get rid of the spacebars...

# Usage - Run from the folder you want to execute on.
#   e.g., 
#   ~/00blair/gitrepos/shelltricks/tricks/rename-folders-then-unrename.sh $(pwd)

for i in $(find "$1" -type d -depth 1 | sort -r);
do
	mv "$i" "$i""_4f307740-584a-4aa4-91c3-c2d786a4eef8"
done

for i in $(find "$1" -type d -depth 1 | sort -r);
do
	rename "s/_4f307740-584a-4aa4-91c3-c2d786a4eef8//g" "$i"
done
