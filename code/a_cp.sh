#!/bin/zsh

#
# grab files from mail attachments folder
#


# SAVEPWD=$PWD
SAVEIFS=$IFS

mkdir -p ~/docs/gmp_validation/data/inbox
# cd ~/docs/gmp_validation/

# save IFS and set to \n\b to handle the fucking spaces in filenames
IFS=$(echo -en "\n\b")



source_dir="$HOME/Library/Group Containers/UBF8T346G9.Office/Outlook/Outlook 15 Profiles/Main Profile/Files/S0/2/Attachments"
target_dir="./data/inbox"
cm_fname="*CM_Data_Fluctuation*.zip"
dv_fname="dv_fluctuation*.zip"

if [ ! -d "$source_dir" ]; then
    echo "Source directory $source_dir does not exist."
    exit 1
fi

if [ ! -d "$target_dir" ]; then
    echo "Target directory $target_dir does not exist."
    exit 1
fi


copy_files_test () {
    iters=0
    fname=$1
    files=($(find "$source_dir" -name "$fname"))
    
    if [ ${#files[@]} -eq 0 ];
    then
	echo "No files found in Outlook attachments folder with $1 pattern..."
	echo "Check script folder references."
	exit 1
    fi

    for file in "${files[@]}";
    do
	base_name=$(basename "$file")
	if ! [[ -f "./data/inbox/$base_name" ]];
	then
	    cp $file ./data/inbox/
	    echo "Copied $base_name to inbox."
	# else
	    # echo "$base_name already copied... moving on."
	fi

    done
}

copy_files_test $cm_fname
copy_files_test $dv_fname


# revert! revert!
IFS=$SAVEIFS
# cd $SAVEPWD



#
# jdeerwester, 2024-01-25
#
