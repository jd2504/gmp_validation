#!/bin/bash

#
# script to load dataset to bq
#

platform="CM360"

if [ $# -gt 0 ]
then
    dir=$1
else
    dir="./cm"
fi


# GCP project params
project="gmp-reporting-411717"
dataset="validation"
table="cm_90d"
schema_json="$dir/cm_schema.json"


results_query="select\
	file, count(*) records, sum(impressions)/pow(10,6) impr_mm
	from \`$project.$dataset.$table\`
	group by file
	order by file ;"

iters=0

printf """
################################################
#     Uploading $platform processed reports...     #
################################################

"""


printf "Setting GCP project as $project\n"
gcloud config set project $project
#gcloud components update


# create dataset if it does not exist...
if ! bq ls -n 1000 | grep -q $dataset;
then
    bq --project_id=$project mk $dataset
fi

# create table if it doens not exist...
if ! bq --project_id=$project ls -n 1000 $dataset | grep -q $table;
then
    bq --project_id=$project mk --table "${dataset}.${table}"
fi


for file in "$dir"/proc_*;
do

    filename=$(basename -- "$file")
    datetime=$(date '+%Y-%m-%d %H:%M:%S')
    run_or_not=$(grep $filename tracking | awk -F'\t' '{ print $6 }')
    report_date=$(echo "$file" | sed -n 's/.*_Day_\([0-9]\{8\}\).*/\1/p')
    report_date_formatted="${report_date:0:4}-${report_date:4:2}-${report_date:6:2}"

    
    if [ "$run_or_not" = '0' ];
    then
	printf "Processing $file...\n"
	(( iters++ ))
	
	printf "Processing $report_date_formatted report...\n"
	bq load --source_format=CSV --field_delimiter=tab "${dataset}.${table}" "$file" $schema_json
	printf "n $report_date_formatted report records loaded:\n"
	file_query="select count(*) n \
			   from \`${project}.${dataset}.${table}\`
			   where file = '${file:5}' ;"
	bq query --use_legacy_sql=false $file_query
	
    else
	printf "$report_date_formatted $platform file already uploaded.\n"
    fi

    awk -F'\t' -v OFS='\t' -v filename="$filename" -v datetime="$datetime" '$4 == filename && $6 == "0" { $6 = datetime } 1' tracking > triangle && mv triangle tracking
    
done

printf "%0.s=" {1..80}
printf "\nWrote $iters proc_* files to upload (refer to tracking)\n\n"


bq query --use_legacy_sql=false $results_query






#
# jdeerwester, 2024-01-17
#
