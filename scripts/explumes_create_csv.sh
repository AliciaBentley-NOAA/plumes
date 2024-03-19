#/bin/bash

#################################################################################
# Name of Script: explumes_create_csv.sh
# Contact(s):     Alicia Bentley (alicia.bentley@noaa.gov)
# Purpose of Script: Create .csv files for GEFS/GFS plumes
##################################################################################

set -x

# Set up initial directories and initialize variables

mkdir -p $DATA/logs
mkdir -p $DATA/stat
mkdir -p $DATA/final
export finalstat=$DATA/final

obfound=0
fhr="00"

datehr=${VDATE}${vhr}
obday=`echo $datehr |cut -c1-8`
obhr=`echo $datehr |cut -c9-10`

if [ -e $COMINobsproc/${MODELNAME}.${obday}/${MODELNAME}.t${obhr}z.prepbufr.tm00 ]
then
	obfound=1
else
	echo "WARNING: $COMINobsproc/${MODELNAME}.${obday}/${MODELNAME}.t${obhr}z.prepbufr.tm00 is missing, METplus will not run"
	if [ $SENDMAIL = "YES" ]; then
		export subject="Prepbufr Data Missing for EVS ${COMPONENT}"
		echo "Warning: The ${obday} prepbufr file is missing for valid date ${VDATE}. METplus will not run." > mailmsg
		echo "Missing file is $COMINobsproc/${MODELNAME}.${obday}/${MODELNAME}.t${obhr}z.prepbufr.tm00" >> mailmsg
		echo "Job ID: $jobid" >> mailmsg
		cat mailmsg | mail -s "$subject" $MAILTO
	fi
fi

echo $obfound

log_dir="$DATA/logs/${MODELNAME}${typtag}"
if [ -d $log_dir ]; then
	log_file_count=$(find $log_dir -type f | wc -l)
	if [[ $log_file_count -ne 0 ]]; then
		log_files=("$log_dir"/*)
		for log_file in "${log_files[@]}"; do
		if [ -f "$log_file" ]; then
			echo "Start: $log_file"
			cat "$log_file"
			echo "End: $log_file"
		fi
	done
	fi
fi

done



exit
