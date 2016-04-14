#!/bin/sh
#number of cores to reserve for job
nthreads=8

#full s3 path where networks will go
s3="s3://metanetworks/HBCC/Schizophrenia/"

#location of data file
dataFile="/shared/HBCC/hbccSchizophreniaRNAseq.csv"

#location of metanetwork synapse scripts
pathv="/shared/metanetworkSynapse/"

#output path for temporary result file prior to pushing to s3/synapse
outputpath="/local/HBCC/Schizophrenia/"

#path within s3
s3b="HBCC/Schizophrenia"

#id of folder with networks to combine
networkFolderId="syn5917267"

#id of folder on Synapse that file will go to
parentId="syn5917267"

#path to csv file with annotations to add to file on Synapse
annotationFile="/shared/HBCC/Schizophrenia/annoFile.txt"

provenanceFile="/shared/HBCC/Schizophrenia/provenanceFile.txt"

#path to error output
errorOutput="/shared/HBCC/Schizophrenia/Aggregationerror.txt"

#path to out output
outOutput="/shared/HBCC/Schizophrenia/Aggregationout.txt"

#job script name
jobname="hbccSchizophreniaaggregation"

qsub -v s3=$s3,dataFile=$dataFile,pathv=$pathv,outputpath=$outputpath,s3b=$s3b,parentId=$parentId,annotationFile=$annotationFile,provenanceFile=$provenanceFile,networkFolderId=$networkFolderId -pe orte $nthreads -S /bin/bash -V -cwd -N $jobname -e $errorOutput -o $outOutput $pathv/buildConsensus.sh
