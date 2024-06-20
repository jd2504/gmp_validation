#!/bin/bash

#
# process CM files
# track any changes in tracking
#

# read -p "Enter DIR [RET for cwd]: " DIR
# DIR=${DIR:-~/doc/gmp_validation}
#echo "Unzipping and processing files in $DIR"

SAVEPWD=$PWD
cd ~/doc/gmp_validation/


if [ $# -gt 0 ]
then
    dir=$1
else
    dir="./cm"
fi


iters=0


# tracking
if ! test -f ./tracking;
then
    printf "tracking file does not exist... creating file\n"
    printf "report_date\tplatform\tfile\tprocessed_file\ttime_processed\tuploaded\n" >> tracking
fi


# loop through zip files in cm folder not yet tracked in tracking
for file in "$dir"/*CM_Data_Fluctuation_90_Day*.zip;
do
    csv_file="${file%.zip}.csv"
    base_name=$(basename "$csv_file")
    proc_file="$dir/proc_${base_name%.*}"
    
    if grep -q ${proc_file:5} tracking;
    then
	printf "$file already processed... moving on...\n"
    else
	(( iters++ ))

	# report_date=$(echo "$file" | grep -oP '(?<=_Day_)\d{8}')
	report_date=$(echo "$file" | sed -n 's/.*_Day_\([0-9]\{8\}\).*/\1/p')
	report_date_formatted="${report_date:0:4}-${report_date:4:2}-${report_date:6:2}"

	printf "\nProcessing $report_date_formatted report...\n"

	unzip -d $dir $file


	# strip all of the report settings
	awk '/Date,Advertiser,Advertiser ID/,0' "$csv_file" > "$proc_file"
	sed -i '' -e '$ d' "$proc_file"

	# get rid of caps and special chars in header
	#header=$(head -n 1 "$proc_file" | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | sed 's/[^a-zA-Z0-9_,]//g')
	#{ echo "$header"; tail -n +2 "$proc_file"; } > temp && mv temp "$proc_file"
	tail -n +2 "$proc_file" > tmp && mv tmp "$proc_file"
	
	# add file name to proc_file
	awk -v var="${proc_file:5}" 'BEGIN{FS=OFS=","} { print var","$0 }' \
	    $proc_file | csvformat -T > tmp && mv tmp $proc_file


	if [ $? -eq 0 ];
	then
	    printf "$report_date_formatted\tCM360\t${file##*/}\t${proc_file##*/}\t$(date)\t0\n" >> tracking
	else
	    printf "Error processing file: $file\n"
	fi
	printf "Wrote: ${proc_file:5}\n"
    fi
done


printf "%0.s=" {1..80}
printf "\nWrote $iters CM360 proc_ files to upload (refer to ./tracking for details)\n\n"



#
# jdeerwester, 2024-01-17
#
