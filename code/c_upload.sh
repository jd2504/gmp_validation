#!/bin/zsh

#
# upload datasets to bq
#

# SAVEPWD=$PWD
# cd ~/docs/gmp_validation


if ! [[ "$1" =~ ^(cm|dv|sa)$ ]] && [ $# -gt 0 ];
then
    echo "usage: [platform: cm/dv/sa] [gmp project-id: opt.]"
    exit 1
else
    platform=$1
    project=${2:-gmp-reporting-411717}
fi


source_dir="./data/$platform" # ./data/cm
dataset="validation"
table="${platform}_90d" # cm_90d
schema_json="./data/schemata/${platform}_schema.json"
results_query="select\
	file, count(*)/pow(10,3) records_k, sum(impressions)/pow(10,6) impr_mm
	from \`$project.$dataset.$table\`
	group by file
	order by file desc
	limit 10 ;
"


echo "Setting GCP project as $project"
gcloud config set project $project
#gcloud components update


# create dataset and table if they do not exist
if ! bq ls -n 1000 | grep -q $dataset;
then
    bq --project-id=$project mk $dataset
fi
if ! bq --project_id=$project ls -n 1000 $dataset | grep -q $table;
then
    bq --project_id=$project mk --table "${dataset}.${table}"
fi


# loop through source dir and upload
files=($(find "$source_dir" -name "proc_*"))
if [ ${#files[@]} -eq 0 ];
then
    echo "No processed files found in $source_dir..."
    exit 1
fi

iters=0

for file in "${files[@]}";
do
    base_name=$(basename -- "$file")  # same as proc_name in c_upload w/out the path
    datetime=$(date '+%Y-%m-%d %H:%M:%S')
    run_or_not=$(grep $base_name tracking | awk -F'\t' '{ print $6 }')
    report_date=$(echo "$base_name" | sed 's/.*_\(202[34]\)\([0-9]\{2\}\)\([0-9]\{2\}\)_.*/\1-\2-\3/')

    if [ "$run_or_not" = '0' ];
    then
	echo "Processing $base_name..."
	bq load --source_format=CSV --field_delimiter=tab "${dataset}.${table}" "$file" $schema_json
	echo "$report_date report loaded."
	file_query="select count(*) n
		    from \`${project}.${dataset}.${table}\`
		    where file = '${file:10}' ;"
	# bq query --use_legacy_sql=false $file_query

	# update tracking with dt if uploaded='0'
	(( iters++ ))
	awk \
	    -F'\t' -v OFS='\t' -v filename="$base_name" -v datetime="$datetime" \
	    '$4 == filename && $6 == "0" { $6 = datetime } 1' \
	    tracking > triangle && mv triangle tracking

    # else
	# echo "$report_date $platform file already uploaded... moving on."
    fi
done


printf "%0.s=" {1..80}
printf "\nUploaded $iters ${platform}360 files to $dataset.$table (refer to tracking)\n\n"


echo "Last 10 reports loaded and volumes:"
bq query --use_legacy_sql=false $results_query



# cd $SAVEPWD





#
# jdeerwester, 2024-01-24
#
