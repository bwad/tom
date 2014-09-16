#tom

`tom` is a cli for working with Tomcat in a development environment.

It's useful if any of the following apply: 

- you're lazy,
- you're forgetful (and/or haven't worked with Servlet/JSPs in a while).
- Java IDE's run like pigs on your aging MacBook Pro.

## Dependencies

- Bash 4+
- Tomcat and `CATALINA_HOME` environment varialble.
- Tomcat Client Deployer. (TODO: Fix hard coded path.)
- Gradle (TODO: Gradle wrapper.)
- Other stuff maybe ...

##Installation

###`tom`

1. Download repo.
2. cd into repo directory and run `make`.
3. Add bin/tom to your PATH.
4. Type `tom` at terminal prompt to get Usage screen.

###Tomcat
Make sure CATALINA_HOME environment variable is set to point to the Tomcat install.
### Tomcat Client Deployer
Currently expected to be found in `$CATALINA_HOME/deployer` which is not starndard.

##Usage 

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


##Generated Project Structure
    <name>/
        ├── build
        │   ├── classes
        │   │   └── main
        │   │       └── ExampleServlet.class
        │   ├── dependency-cache
        │   ├── libs
        │   │   └── blue.war
        │   └── tmp
        │       ├── compileJava
        │       └── war
        │           └── MANIFEST.MF
        ├── build.gradle
        ├── build.xml
        ├── src
        │   └── main
        │       ├── java
        │       │   └── ExampleServlet.java
        │       └── webapp
        │           ├── WEB-INF
        │           │   └── web.xml
        │           └── index.jsp
        └── tomcat-tasks.xml

##Workflow
###Gradle+Ant
The Gradle build flow works with the Ant based deploy task in the following steps:

    tom new foobar       // Create project
    cd foobar
    gradle deploy          // Ant based deploy (tomcat-tasks.xml)

**Note:** The `deploy` task dependsOn the `build` task. (See build.gradle)

The Tomcat Client Deployer (TCD) tasks are defined in the tomcat-tasks.xml Ant build file and configured in the build.gradle file. The following TCD tasks are available from gradle:

    Other tasks
    -----------
    deploy - Deploy web application
    reload - Reload web application
    start - Start web application
    stop - Stop web application
    undeploy - Undeploy web application
