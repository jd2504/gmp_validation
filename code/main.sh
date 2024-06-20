#!/bin/zsh

#
# grab files from Outlook attachments: a_cp.sh
# process files: b_process.sh
# upload to bq: c_upload.sh
#


# gcloud cli has issues uninstalling... check whether gcloud is installed properly
if ! command -v gcloud &> /dev/null
then
    echo "gcloud command could not be found - please reinstall"
    exit 1
fi


SAVEPWD=$PWD
cd ~/docs/gmp_validation


echo "Processing files in $dir for $platform to upload..."


# read -p "Enter DIR [RET for cwd]: " dir
# dir=${dir:-.}
# read -p "Process [cm/dv/sa/all]? " platform
# platform=${platform:-}
read -p "RET or enter GCP project-id [gmp-reporting-411717]: " project
project=${project:-gmp-reporting-411717}
read -p "RET or decline to upload [yn]: " upload
upload=${upload:-y}


# gcloud config set project $project
# gcloud components update


echo ""
echo "Copying new files in Outlook attachments"
echo "========================================"
./code/a_cp.sh

process_and_load () {
    platform=$1
    platform_name="${platform}360"

    echo ""
    echo "Processing new $platform_name reports in inbox"
    echo "======================================"
    ./code/b_process.sh $platform
    if [[ $upload == 'y' ]];
    then
	echo ""
	echo "Uploading processed $platform_name reports to BQ"
	echo "========================================"
	./code/c_upload.sh $platform $project
    fi
}

process_and_load cm $project
process_and_load dv $project



cd $SAVEPWD





#
# joel deerwester, 2024-01-24
#
