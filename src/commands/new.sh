
#=============================================================================
#
# new Command.
#
function tom_cmd_new {
  
  local name=$1; shift  # app name
  
  echo "Creating new project \${name} ..."
  mkdir -p ${name}/src/main/java
  mkdir -p ${name}/src/main/webapp/WEB-INF
  tom_new_webxml ${name}/src/main/webapp/WEB-INF/web.xml
  tom_new_indexjsp "${name}/src/main/webapp/index.jsp" "${name}"
  #FORNOW: tom_new_buildxml "${name}/build.xml" "${name}"
  tom_new_buildgradle "${name}/build.gradle" "${name}"
  #FORNOW: tom_new_pomxml "${name}/pom.xml" "${name}"
  tom_new_tomcattasks "${name}/tomcat-tasks.xml"  "${name}"
  tom_new_servlet "${name}/src/main/java/ExampleServlet.java"  "${name}"
}

function tom_new_webxml {
    
  local dstpath=$1
  
  printf -- "Creating $dstpath...\n"
    
    cat > ${dstpath}<<WEBXML
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee 
            http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         version="3.1">
  <display-name>tom Created Web Application</display-name>
</web-app>
WEBXML

}


function tom_new_indexjsp {
    
  local dstpath=$1
  local name=$2
    
  printf -- "Creating $dstpath...\n"
    
  cat > ${dstpath}<<INDEXJSP
<html>
<body>
<h2>Hello ${name}!</h2>
</body>
</html>
INDEXJSP

}

function tom_new_buildgradle {
  
  local dstpath=$1
  local name=$2

  printf -- "Creating $dstpath...\n"
  
  cat > ${dstpath}<<BUILDGRADLE
apply plugin: 'java'
apply plugin: 'war'

// Ant configuration needs to be done before import or it will fail.
ant.properties.build = "./build"
ant.properties.username = "brant"
ant.properties.password="scala"
ant.properties.webapp = "${name}"
ant.properties.path = "/${name}"
ant.properties.url = "http://localhost:8080/manager/text"
ant.properties.'webapp.path' = "build/libs/${name}"
ant.properties.tomcat="\${System.getenv('CATALINA_HOME')}"

ant.importBuild 'tomcat-tasks.xml'

deploy.dependsOn build

repositories {
   mavenCentral()
}

dependencies {
  providedCompile 'javax.servlet:javax.servlet-api:3.1.0'
  runtime 'javax.servlet:jstl:1.2'
}
BUILDGRADLE
}

function tom_new_pomxml {
  
  local dstpath=$1
  local name=$2

  printf -- "Creating $dstpath...\n"
  
  cat > ${dstpath}<<POMXML
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.acme</groupId>
  <artifactId>my-webapp</artifactId>
  <packaging>war</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>my-webapp Maven Webapp</name>
  <url>http://maven.apache.org</url>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
    <dependency>
    	<groupId>org.apache.tomcat</groupId>
    	<artifactId>tomcat-servlet-api</artifactId>
    	<version>8.0.12</version>
    </dependency>
  </dependencies>
  <build>
    <finalName>my-webapp</finalName>
     <plugins>
       <plugin>
         <groupId>org.codehaus.mojo</groupId>
         <artifactId>tomcat-maven-plugin</artifactId>
         <configuration>
             <url>http://localhost:8080/manager/html</url>
             <server>mytomcat</server>
             <path>/my-app</path>
         </configuration>
       </plugin>
     </plugins>
   </build>
</project>

POMXML
}

function tom_new_servlet {
  
  local dstpath=$1
  local name=$2

  printf -- "Creating $dstpath...\n"
  
  cat > ${dstpath}<<SERVLET
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;

@WebServlet("/example")
public class ExampleServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.println("... your example servlet is working ...");
        out.close();
    }
}
SERVLET
}

function tom_new_buildxml {
  
  local dstpath=$1
  local name=$2

  printf -- "Creating $dstpath...\n"
  
  cat > ${dstpath}<<BUILDXML
<?xml version='1.0' encoding='utf-8'?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<project name="Deployer" default="compile" basedir=".">

  <property file="deployer.properties"/>

  <!-- Configure the directory into which the web application is built -->
  <property name="build"    value="\${basedir}/build"/>

  <!-- Configure the folder and context path for this application -->
  <property name="webapp"   value="${name}"/>
  <property name="path"     value="/${name}"/>

  <!-- Configure properties to access the Manager application -->
  <property name="url"      value="http://localhost:8080/manager/text"/>
  <property name="username" value="brant"/>
  <property name="password" value="scala"/>

  <property name="webapp.path"     value="\${build}/webapp\${path}"/>

  <path id="deployer.classpath">
    <fileset dir="/usr/local/tomcat/8.0.12/deployer/lib">
      <include name="*.jar"/>
    </fileset>
  </path>

  <!-- Configure the custom Ant tasks for the Manager application -->
  <taskdef resource="org/apache/catalina/ant/catalina.tasks"
           classpathref="deployer.classpath"/>

  <!-- Executable Targets -->
  <target name="clean" description="Removes build directory">
    <delete dir="\${build}" />
  </target>

  <target name="compile" description="Compile web application"
          depends="clean">

    <copy todir="\${webapp.path}">
      <fileset dir="\${webapp}" />
    </copy>

    <jasper validateXml="false"
             uriroot="\${webapp.path}"
             webXmlFragment="\${webapp.path}/WEB-INF/generated_web.xml"
             addWebXmlMappings="true"
             outputDir="\${webapp.path}/WEB-INF/classes" />

    <validator path="\${webapp.path}" />

    <mkdir dir="\${webapp.path}/WEB-INF/classes"/>
    <mkdir dir="\${webapp.path}/WEB-INF/lib"/>

    <javac destdir="\${webapp.path}/WEB-INF/classes"
           optimize="off"
           debug="\${compile.debug}"
           deprecation="\${compile.deprecation}"
           failonerror="false"
           srcdir="\${webapp.path}/WEB-INF/classes"
           encoding="UTF-8"
           excludes="**/*.smap">
      <classpath>
        <fileset dir="\${webapp.path}/WEB-INF/lib">
          <include name="*.jar"/>
        </fileset>
        <fileset dir="/usr/local/tomcat/8.0.12/deployer/lib">
          <include name="*.jar"/>
        </fileset>
      </classpath>
      <include name="**" />
      <exclude name="tags/**" />
    </javac>

    <jar destfile="\${webapp.path}.war"
         basedir="\${webapp.path}" />

  </target>

  <target name="deploy" description="Deploy web application">
    <deploy url="\${url}" username="\${username}" password="\${password}"
            path="\${path}" war="\${webapp.path}.war" update="true" />
  </target>

  <target name="undeploy" description="Undeploy web application">
    <undeploy url="\${url}" username="\${username}" password="\${password}"
              path="\${path}"/>
  </target>

  <!-- Webapp lifecycle control -->
  <target name="start" description="Start web application">
    <start url="\${url}" username="\${username}" password="\${password}"
           path="\${path}"/>
  </target>
  <target name="reload" description="Reload web application">
    <reload url="\${url}" username="\${username}" password="\${password}"
            path="\${path}"/>
  </target>
  <target name="stop" description="Stop web application">
    <stop url="\${url}" username="\${username}" password="\${password}"
          path="\${path}"/>
  </target>

</project>

BUILDXML

}

function tom_new_tomcattasks {
  
  local dstpath=$1
  local name=$2

  printf -- "Creating $dstpath...\n"
  
  cat > ${dstpath}<<GRADLEDEPLOY
<?xml version='1.0' encoding='utf-8'?>
<!--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
<project name="Deployer" default="deploy" basedir=".">

  <path id="deployer.classpath">
    <fileset dir="\${tomcat}/deployer/lib">
      <include name="*.jar"/>
    </fileset>
    <fileset dir="\${tomcat}/lib">
      <include name="*.jar"/>
    </fileset>
  </path>

  <!-- Configure the custom Ant tasks for the Manager application -->
  <taskdef resource="org/apache/catalina/ant/catalina.tasks"
           classpathref="deployer.classpath"/>

  <target name="deploy" description="Deploy web application">
    <deploy url="\${url}" username="\${username}" password="\${password}"
            path="\${path}" war="\${webapp.path}.war" update="true" />
  </target>

  <target name="undeploy" description="Undeploy web application">
    <undeploy url="\${url}" username="\${username}" password="\${password}"
              path="\${path}"/>
  </target>

  <!-- Webapp lifecycle control -->
  <target name="start" description="Start web application">
    <start url="\${url}" username="\${username}" password="\${password}"
           path="\${path}"/>
  </target>
  <target name="reload" description="Reload web application">
    <reload url="\${url}" username="\${username}" password="\${password}"
            path="\${path}"/>
  </target>
  <target name="stop" description="Stop web application">
    <stop url="\${url}" username="\${username}" password="\${password}"
          path="\${path}"/>
  </target>

</project>

GRADLEDEPLOY
}