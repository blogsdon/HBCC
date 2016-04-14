#!/bin/bash

#number of cores to reserve for job
nthreads=319

#full s3 path where networks will go
s3="s3://metanetworks/HBCC/Bipolar/"

#location of data file
dataFile="/shared/HBCC/hbccBipolarRNAseq.csv"

#location of metanetwork synapse scripts
pathv="/shared/metanetworkSynapse/"

#output path for temporary result file prior to pushing to s3/synapse
outputpath="/shared/HBCC/Bipolar/"

#path within s3
s3b="HBCC/Bipolar"

#id of folder on Synapse that files will go to
parentId="syn5917259"

#path to csv file with annotations to add to file on Synapse
annotationFile="/shared/HBCC/Bipolar/annoFile.txt"

#path to csv file with provenance to add to file on synapse
provenanceFile="/shared/HBCC/Bipolar/provenanceFileRegression.txt"

#path to error output
errorOutput="/shared/HBCC/Bipolar/Regressionerror.txt"

#path to out output
outOutput="/shared/HBCC/Bipolar/Regressionout.txt"

#job script name
jobname="hbccRegressionBipolar"


echo "qsub -v s3=$s3,dataFile=$dataFile,pathv=$pathv,c3net=0,mrnet=0,wgcnaTOM=0,sparrowZ=1,lassoCV1se=1,ridgeCV1se=1,genie3=1,tigress=1,numberCore=$nthreads,outputpath=$outputpath,s3b=$s3b,parentId=$parentId,annotationFile=$annotationFile,provenanceFile=$provenanceFile -pe orte $nthreads -S /bin/bash -V -cwd -N $jobname -e $errorOutput -o $outOutput $pathv/buildNet.sh"

qsub -v s3=$s3,dataFile=$dataFile,pathv=$pathv,c3net=0,mrnet=0,wgcnaTOM=0,sparrowZ=1,lassoCV1se=1,ridgeCV1se=1,genie3=1,tigress=1,numberCore=$nthreads,outputpath=$outputpath,s3b=$s3b,parentId=$parentId,annotationFile=$annotationFile,provenanceFile=$provenanceFile -pe orte $nthreads -S /bin/bash -V -cwd -N $jobname -e $errorOutput -o $outOutput $pathv/buildNet.sh
