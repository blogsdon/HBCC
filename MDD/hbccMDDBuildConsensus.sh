#!/bin/sh
#number of cores to reserve for job
nthreads=8

#full s3 path where networks will go
s3="s3://metanetworks/HBCC/MDD/"

#location of data file
dataFile="/shared/HBCC/hbccMDDRNAseq.csv"

#location of metanetwork synapse scripts
pathv="/shared/metanetworkSynapse/"

#output path for temporary result file prior to pushing to s3/synapse
outputpath="/local/HBCC/MDD/"

#path within s3
s3b="HBCC/MDD"

#id of folder with networks to combine
networkFolderId="syn5917266"

#id of folder on Synapse that file will go to
parentId="syn5917266"

#path to csv file with annotations to add to file on Synapse
annotationFile="/shared/HBCC/MDD/annoFile.txt"

provenanceFile="/shared/HBCC/MDD/provenanceFile.txt"

#path to error output
errorOutput="/shared/HBCC/MDD/Aggregationerror.txt"

#path to out output
outOutput="/shared/HBCC/MDD/Aggregationout.txt"

#job script name
jobname="hbccMDDaggregation"

qsub -v s3=$s3,dataFile=$dataFile,pathv=$pathv,outputpath=$outputpath,s3b=$s3b,parentId=$parentId,annotationFile=$annotationFile,provenanceFile=$provenanceFile,networkFolderId=$networkFolderId -pe orte $nthreads -S /bin/bash -V -cwd -N $jobname -e $errorOutput -o $outOutput $pathv/buildConsensus.sh
