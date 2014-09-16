
#=============================================================================
#
# deploy Command.
#
function tom_cmd_deploy {
  
  # Both libs are required because the deployer needs a couple of libs not in tomcat8.
  local deployer_lib=$CATALINA_HOME/deployer/lib
  local tomcat_lib=$CATALINA_HOME/lib
  
  echo "Deploying ..."
  # ant -lib $deployer_lib -lib $tomcat_lib clean compile deploy
  gradle --daemon deploy
}

