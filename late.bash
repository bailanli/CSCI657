#!/bin/bash

STUDENTS=$(ls -d *-Assignment1/)
DIR=$PWD

ASSIGNMENT=4b
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
4b)
  TAG=a4bhandin
  FOLDER=shardkv
  ;;
*)
  ;;
esac

for STUDENT in $STUDENTS
do
  #echo "  "$student
  cd $DIR/$STUDENT
  git checkout --quiet master
  git pull --quiet
  git checkout --quiet tags/$TAG
  DATE_TIME=`git log --tags=${TAG} -1 --format="%ci"`
  CONVERT_DATE_TIME=`date -d"${DATE_TIME}" "+%D %T"`
  git log --tags=$TAG -1 --format="${STUDENT:0:-13};${CONVERT_DATE_TIME};%d" 
done
