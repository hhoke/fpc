#!/bin/bash

function test_suite {
  #flag
  _fpc_err=0
  # setup
  testdir=$(mktemp -d) 

  deepdir=$testdir/first/second/third
  mkdir -p $deepdir

  noPermsFile=$deepdir/noPerms
  touch $noPermsFile
  chmod 000 $noPermsFile

  lostDir=$testdir/first/secondNoPerm/third
  mkdir -p $lostDir

  noPermsDir=$testdir/first/secondNoPerm
  mkdir -p $noPermsDir
  chmod 000 $noPermsDir

  ExistsFile=$(mktemp)
  #Note for later: inconsistent camelCase and python_style
  # test fpc  
  test_returnval "fpc $deepdir" 0
  test_returnval "fpc $noPermsFile" 1
  test_returnval "fpc $lostDir" 1
  test_error_message "fpc $noPermsFile" "path exists with -x permissions up to '$(dirname $noPermsFile)'\n==========| '$noPermsFile' does not have permission -r"
  test_error_message "fpc $lostDir" "path exists with -x permissions up to '$(dirname $lostDir)'\n==========| '$noPermsFile' does not have permission -r"

  # test ppc

  # clean up
  
  sudo rm -r $testdir

  # return useful error code
  return $_fpc_err
}

function test_error_message {
  cmd=$1
  intended_error=$2
  error_string=$($cmd)
  returnval=$?
  if [ "$returnval" != "$target_returnval" ];then
    echo "failed error for $cmd: $error instead of $intended_error"
    _fpc_err=1
  fi 
}

function test_returnval {
  cmd=$1
  target_returnval=$2
  $cmd
  returnval=$?
  if [ $returnval != $target_returnval ];then
    echo "failed return value for $cmd: $returnval instead of $target_returnval"
    _fpc_err=1
  fi 
}

. ./ppc
test_suite


