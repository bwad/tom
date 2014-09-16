
#=============================================================================
#
# logs Command.
#
function tom_cmd_logs {
  local logs_n=20 # default
  
  while getopts "n:"  TOMOPT
  do
    case $TOMOPT in
      n)logs_n=$OPTARG;;
    esac
  done
  
  echo "Tomcat logs (catalina.out): ( -n $logs_n)"
  tail -n $logs_n $CATALINA_HOME/logs/catalina.out
  echo "(last $logs_n entries of catalina.out shown)"
}

