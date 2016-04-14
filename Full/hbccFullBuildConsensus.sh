#!/bin/sh
#number of cores to reserve for job
nthreads=8

#full s3 path where networks will go
s3="s3://metanetworks/HBCC/Full/"

#location of data file
dataFile="/shared/HBCC/hbccRNAseq.csv"

#location of metanetwork synapse scripts
pathv="/shared/metanetworkSynapse/"

#output path for temporary result file prior to pushing to s3/synapse
outputpath="/local/HBCC/Full/"

#path within s3
s3b="HBCC/Full"

#id of folder with networks to combine
networkFolderId="syn5917265"

#id of folder on Synapse that file will go to
parentId="syn5917265"

#path to csv file with annotations to add to file on Synapse
annotationFile="/shared/HBCC/Full/annoFile.txt"

provenanceFile="/shared/HBCC/Full/provenanceFile.txt"

#path to error output
errorOutput="/shared/HBCC/Full/Aggregationerror.txt"

#path to out output
outOutput="/shared/HBCC/Full/Aggregationout.txt"

#job script name
jobname="hbccFullaggregation"

qsub -v s3=$s3,dataFile=$dataFile,pathv=$pathv,outputpath=$outputpath,s3b=$s3b,parentId=$parentId,annotationFile=$annotationFile,provenanceFile=$provenanceFile,networkFolderId=$networkFolderId -pe orte $nthreads -S /bin/bash -V -cwd -N $jobname -e $errorOutput -o $outOutput $pathv/buildConsensus.sh
