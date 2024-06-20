#!/bin/bash


SAVEPWD=$PWD
cd ~/doc/gmp_validation/


if [ $# -gt 0 ]
then
    dir=$1
else
    dir="./dv"
fi


iters=0


# tracking
if ! test -f ./tracking;
then
    printf "tracking file does not exist... creating file\n"
    printf "report_date\tplatform\tfile\tprocessed_file\ttime_processed\tuploaded\n" >> tracking
fi


# loop through dv zip files not yet tracked in tracking
for file in "$dir"/dv_fluctuation_*.zip;
do
    csv_file="${file%.zip}.csv"
    base_name=$(basename "$csv_file")
    proc_file="$dir/proc_${base_name%.*}"

    if grep -q ${proc_file:5} tracking;
    then
	printf "$file already processed... moving on...\n"
    else
	(( iters++ ))

	report_date=$(echo "$file" | sed -n 's/.*_fluctuation_\([0-9]\{8\}\).*/\1/p')
	report_date_formatted="${report_date:0:4}-${report_date:4:2}-${report_date:6:2}"

	printf "\nProcessing $report_date_formatted report...\n"

	unzip -d $dir $file


	# strip report settings
	awk -F, 'BEGIN { OFS = FS } $1 != "" { print; next } { exit }' "$csv_file" > "$proc_file"
	#awk -F, 'BEGIN {OFS = FS} $1 != ""' "$csv_file" > "$proc_file"
	# ... and header
	tail -n +2 "$proc_file" > tmp && mv tmp "$proc_file"

	# add file name to proc_file
	awk -v var="${proc_file:5}" 'BEGIN{ FS = OFS = "," } { print var","$0 }' \
	    $proc_file | csvformat -T | \
	    sed -E 's,\t([0-9]{4})/([0-9]{2})/([0-9]{2})\t,\t\1-\2-\3\t,g' \
	    > tmp && mv tmp $proc_file


	if [ $? -eq 0 ];
	then
	    printf "$report_date_formatted\tDV360\t${file##*/}\t${proc_file##*/}\t$(date)\t0\n" >> tracking
	else
	    printf "Error processing file: $file\n"
	fi
	printf "Wrote: ${proc_file:5}\n"
    fi
done


printf "%0.s=" {1..80}
printf "\nWrote $iters DV360 proc_ files to upload (refer to ./tracking for details)\n\n"



cd $SAVEPWD


#
# jdeerwester, 2024-01-22
#
