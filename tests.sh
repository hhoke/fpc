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
  noExistsDir=$testdir/notDir
  noExistsFile=$testdir/first/notFile
  
  
  #Note for later: inconsistent camelCase and python_style
  # test fpc  
  test_returnval "fpc $deepdir" 0
  test_returnval "fpc $noPermsFile" 77
  test_returnval "fpc $lostDir" 77
  test_returnval "fpc $noExistsDir" 66
  test_returnval "fpc $noExistsFile" 66

  test_error_message "fpc $noPermsFile" "'$noPermsFile' does not have permission -r"
  test_error_message "fpc $lostDir" "path exists with -x permissions up to '$(dirname $noPermsDir)'
==========| '$(basename $noPermsDir)' does not have permission -x"
  test_error_message "fpc $noExistsDir " "path exists with -x permissions up to '$testdir'
==========| 'notDir' does not exist"
  test_error_message "fpc $noExistsFile " "path exists with -x permissions up to '$testdir/first'
==========| 'notFile' does not exist"
  test_error_message "fpc $noPermsFile --parseable" "$(dirname $noPermsFile)"
  test_error_message "fpc $lostDir --parseable" "$testdir/first"
  test_error_message "fpc $noExistsDir --parseable" "$testdir"
  test_error_message "fpc $noExistsFile --parseable" "$testdir/first"

  # test ppc

  # clean up
  
  sudo rm -r $testdir

  # return useful error code
  return $_fpc_err
}

function test_error_message {
  cmd=$1
  intended_error=$2
  error_string="$($cmd)"
  returnval=$?
  if [ "$intended_error" != "$error_string" ];then
    echo
    echo :::
    echo "failed error for $cmd:"
    echo "[$error_string]" instead of 
    echo "[$intended_error]"
    _fpc_err=1
  else
    echo
    echo 'PASSED'
  fi 

}

function test_returnval {
  cmd=$1
  target_returnval=$2
  $cmd
  returnval=$?
  if [ $returnval != $target_returnval ];then
    echo
    echo :::
    echo "failed return value for $cmd: $returnval instead of $target_returnval"
    _fpc_err=1
  else
    echo 'PASSED'
  fi 
}

. ./ppc
test_suite


