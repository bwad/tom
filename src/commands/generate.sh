
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
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ${sname} extends HttpServlet {
  public void doGet(HttpServletRequest request, 
         HttpServletResponse response)
        throws ServletException, IOException
  {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    out.println("<title>${name}</title>" + "<body bgcolor=FFFFFF>");
    out.println("<h2>Hello ${name}</h2>");
    out.close();
  }
}
SERVLET
}

