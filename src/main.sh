
#=============================================================================
#
#   Main
#
#   Possible enchancements:
#       - 
#=============================================================================

#
# Handle lone -h option
# 
if [[ $1 == "-h" || $# -eq 0 ]]; then tom_usage; exit 0; fi

CMD=$1; shift
case $CMD in

  new) tom_cmd_new "$@" ;;
  start) tom_cmd_start "$@" ;;
  stop) tom_cmd_stop "$@" ;;
  logs) tom_cmd_logs "$@" ;;
  deploy) tom_cmd_deploy "$@" ;;
  g|ge|gen|gene|gener|genra|generat|generate) tom_cmd_generate "$@" ;;
  
  # Extras:  (may be temporary)
  build) gradle --daemon build ;;
  
    
  *) printf -- "ERROR: Unknown command $CMD\n"
    ;;
esac

