
#=============================================================================
#
# generate Command.
#
function tom_cmd_generate {
  
  # Command parrameters
  local what=$1;shift
  local name=$1;shift
    
  # Handle options
  local tmpl=""
  while getopts "t:"  TOMOPT
  do
    case $TOMOPT in
      t)tmpl=$OPTARG;;
    esac
  done
  
  printf --  "\n====================\n"
  printf --   "what: $what\n"
  printf --   "name: $name\n"
  printf --   "template: $tmpl\n"
  printf --   "====================\n\n"
  
  case $what in
  servlet)   
    printf -- "Generating Servlet ${name}...\n\n" 
    servlet "${name}"
    ;;
  esac
}

#=============================================================================
# generate servlet 
#=============================================================================
function servlet {

  local name=$1
  local sname="${name^}Servlet"
  local dstpath="src/main/java/${sname}.java"
  
  printf -- "Creating $dstpath...\n"
    
    cat > "${dstpath}"<<SERVLET
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;

@WebServlet("/${name}")
public class ${sname} extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.println("... ${sname} is working ...");
        out.close();
    }
}
SERVLET
}

