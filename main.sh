#!/bin/sh

#4G
wdir=~/.gconfd/seaplane/lte.sites
cd ${wdir}/
#mkdir ${wdir}/old
date=`date '+%m_%d_%Y_%H_%M'`
#cp -p ${wdir}/4g_sites_all.csv  ${wdir}/old/4g_sites_all_$date.csv
#cp -p ${wdir}/3g_sites_all.csv  ${wdir}/old/3g_sites_all_$date.csv
#mv ${wdir}/4g_sites_all.csv ${wdir}/4g_sites_all_old.csv
/opt/ericsson/ddc/util/bin/listme | grep LTE_ | sed -e 's/[@=,]/ /g' | awk '{print $4";"$6";"$7}'  | uniq | sort | unix2dos > ${wdir}/4g_sites_all_temp.csv
/opt/ericsson/ddc/util/bin/listme | grep RN | sed -e 's/[@=,]/ /g' | awk '{print $4";"$6";"$7}'  | uniq | sort | unix2dos > ${wdir}/3g_sites_all_temp.csv
#add headers
gawk 'NR==1{1;print "SubNetwork;NODE_NAME;NODE_IP"}1' ${wdir}/4g_sites_all_temp.csv > ${wdir}/4g_sites_all.csv
gawk 'NR==1{1;print "RNC;NODE_NAME;NODE_IP"}1' ${wdir}/3g_sites_all_temp.csv > ${wdir}/3g_sites_all.csv
rm -rf 4g_sites_all_temp.csv
rm -rf 3g_sites_all_temp.csv
tar -czvf 4g_site_all_$date.tar.gz 4g_sites_all.csv 
tar -czvf 3g_site_all_$date.tar.gz 3g_sites_all.csv
rm -rf 4g_sites_all.csv
rm -rf 3g_sites_all.csv
#echo "send result via email"
#cd ${wdir}/
#${wdir}/smail.sh 4g_sites_all.csv

#clean old files
#find ${wdir}/old -name "*.csv" -mtime +15 -exec rm '{}' \;

