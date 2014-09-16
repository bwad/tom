#!/usr/bin/env bash

function tom_usage {

    cat <<'USAGE'

Simple cli tool for working with Tomcat in a development environment.

Usage:

  tom [command] [command parameters] [options] 

Commands:

  new <name>      - Create new project.
  start           - Start Tomcat server.
  stop            - Stop Tomcat server.
  logs [ -n <#>]  - Display <#> lines from tail of logs/catalina.out
  deploy          - Deploy webapp to server. (depends on build)
  build           - Build webapp
  generate        - (Work in progress!)
  
Options:

  -h    Display this message and exit.
  -n    Specify number of lines to show in 'logs' commmand.

USAGE
    
}
