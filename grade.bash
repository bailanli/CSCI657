#!/bin/bash

if [ "$1" == "" ]
then
  echo "grade.bash all|folder"
else if [ "$1" == "all" ]
     then
       STUDENTS=$(ls -d *-Assignment1/)
     else
       STUDENTS=$1
     fi
fi

ASSIGNMENT=4a
DIR=$PWD
#TAG=a1p1
#FOLDER=wordcount

case "$ASSIGNMENT" in
1)
  TAG=a1handin
  FOLDER=mapreduce
  ;;
2a)
  TAG=a2ahandin
  FOLDER=viewservice
  ;;
2b)
  TAG=a2bhandin
  FOLDER=pbservice
  ;;
3a)
  TAG=a3ahandin
  FOLDER=paxos
  ;;
3b)
  TAG=a3bhandin
  FOLDER=kvpaxos
  ;;
4a)
  TAG=a4ahandin
  FOLDER=shardmaster
  ;;
*)
  ;;
esac
GRADE=grade
LOG_FILE=${FOLDER}.log

# check out code
for STUDENT in $STUDENTS
do
  echo "checking out "$STUDENT
  cd $DIR/$STUDENT
  git checkout --quiet master
  git pull --quiet
  git checkout --quiet tags/$TAG
  #get the orignal version of test_test.go
  git checkout --quiet tags/a1handin src/$FOLDER/test_test.go
done

# run test
for STUDENT in $STUDENTS
do
  echo $STUDENT
  cd $DIR/$STUDENT
  export GOPATH=$DIR/$STUDENT
  #cd src/main
  cd src/$FOLDER
  rm $DIR/$GRADE/$STUDENT/$FOLDER -rf
  mkdir -p $DIR/$GRADE/$STUDENT/$FOLDER
  for i in {1..10}
  do
    echo "========== $i run =========="
    LOG_FILE=$DIR/$GRADE/$STUDENT/$FOLDER/${FOLDER}.log.$i
    ERR_FILE=$DIR/$GRADE/$STUDENT/$FOLDER/${FOLDER}.err.$i
    go test 1> $LOG_FILE 2> $ERR_FILE
    #bash test-wc.sh 1> $LOG_FILE 2> $ERR_FILE
    #rm mrtmp.*
    sleep 1
  done
done
