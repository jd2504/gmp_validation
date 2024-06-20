#!/bin/bash

project="gmp-reporting-411717"
gcloud config set project $project

printf "\nWhat do you want to run?\n"
printf "===========================\n"
read -p "Enter platform [cm/dv/sa]: " platform
platform=${platform:-cm}
read -p "Enter date [YYYY-MM-DD]: " dt
dt=${dt:-2024-01-16}
read -p "Enter max range [15]: " rng
rng=${rng:-15}
read -p "Enter metric [impressions]: " metric
metric=${metric:-impressions}

#declare -A platform_lookup
#platform_array=( ["cm"]="cm_90d" ["dv"]="dv_90d" ["sa"]="sa_90d" )
#platform_tbl="${platform_lookup[$platform]}"

platform_tbl="${platform}_90d"

if [[ "$platform" == "cm" ]];
then
    filesubst="Day_"
elif [[ "$platform" == "dv" ]];
then
    filesubst="fluctuation_"
else
    filesubst="unknown"
fi


printf "\n${platform}360 change in $metric for $dt event date:\n"

query="with a as (
select
    regexp_extract(file, r'${filesubst}(2024[0-9]{4})') report_dt,
    sum($metric) n
from \`validation.${platform_tbl}\`
where event_date = '$dt'
group by 1
order by 1
limit $rng)


select
    date_diff(parse_date('%Y%m%d', report_dt), '$dt', day) days_since_dt,
    report_dt,
    n,
    round(
	ifnull(
	    safe_multiply(
                100,
		safe_subtract(n/lag(n) over(order by report_dt asc), 1)),
            0),
        4) || '%' pct_change

from a
order by 1 ;"


#echo $query
bq query --use_legacy_sql=false $query
