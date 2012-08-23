

import javax.script.*;
import java.util.*;
import java.io.*;
import java.nio.*;
import java.nio.channels.*;
import java.nio.charset.*;

/*
  Author: Karl Kirch 2012
  A general purpose javascript runner via Rhino with some niceties
//*/

public class JSMain {

  private ScriptEngine sEngine = null;
  private Bindings bindings = null;
  private List<String> loadedScripts = new ArrayList<String>();
  private String[] args = null;

  public String[] args() {
    return args;
  }

  //return usage string
  private String jsMainHelpString() {
    String help = "";
    help += "Usage: javac JSMain <scriptName> [additional args]";
    return help;
  }

  /*
    Read file into a string
    via stackoverflow @erickson
    http://stackoverflow.com/questions/326390/how-to-create-a-java-string-from-the-contents-of-a-file/326440#326440
  */
  public String readFile(String path) throws IOException {
    FileInputStream stream = new FileInputStream(new File(path));
    try {
      FileChannel fc = stream.getChannel();
      MappedByteBuffer bb = fc.map(FileChannel.MapMode.READ_ONLY, 0, fc.size());
      /* Instead of using default, pass in a decoder. */
      return Charset.defaultCharset().decode(bb).toString();
    }
    finally {
      stream.close();
    }
  }

  //eval a javascript with the cached bindings object
  public void evalScript(String script) {
    try {
      sEngine.eval(script,bindings);
    } catch (ScriptException ex) {
      ex.printStackTrace();
    }
  }

  //load then eval the script if it hasn't been loaded before
  public void loadAndEvalScript(String path) {
    if (loadedScripts.contains(path)) return;
    String script = null;
    try {
      script = readFile(path);
    } catch (IOException ioe) {
      ioe.printStackTrace();
      return;
    }
    evalScript(script);
    loadedScripts.add(path);
  }

  //constructor
  public JSMain(String...args) {
    this.args = args;

    //if no script name passed in or if help is indicated return usage string
    if (args.length == 0 || "-h".equals(args[0]) || "--help".equals(args[0])) {
      System.out.println(jsMainHelpString());
      System.exit(1);
    }

    ScriptEngineManager seMgr = new ScriptEngineManager();
    sEngine = seMgr.getEngineByName("JavaScript");

    String script = null;

    //test to see if passed in script path exists
    try {
      script = readFile(args[0]);
    } catch (IOException ioe) {
      ioe.printStackTrace();
      System.out.println("\nAre you sure you passed in a path to your script file as arg[0]?");
      System.exit(1);
    }
    
    //create a global bindings object to facilitate a global scope
    bindings = sEngine.createBindings();
    
    //expose the script manager to the global context
    bindings.put("SCRIPT_MANAGER", this);
    
    //create and expose a load function to include other js files into the global scope
    evalScript("load = function(path) {" +
        "SCRIPT_MANAGER.loadAndEvalScript(path);" +
      "};");

    //load the initial script file
    loadAndEvalScript(args[0]);

  }

  public static void main(String...args) {
    new JSMain(args);
  }

}

