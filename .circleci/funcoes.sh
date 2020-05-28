#!/usr/bin/env bash

function ambiente_vars() {
  local env=$1
  
  vars={$(printenv | egrep -o "${env}_CI_.*=" | awk -F= '{print $1}')}

  for var in "${vars[@]}"; do  
    var=$(echo "${var}" | awk -F '=' '{print $1}')
    new_var=$(echo "${var}" | cut -d'_' -f3-)
    export "{new_var}"="${!var}"            
  done
}