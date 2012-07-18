#SERVICES.rb
# Helper classes to start services
# SerenaTomcat
# Dimensions Listener
#

class ALMServices
  require 'open3'
  
  OS = RbConfig::CONFIG["host_os"]

  def startWinService(service)
      if "mingw32" == OS || "mingw64" == OS
        command = "net start " + service
        status = false
    
        #puts command
        stdin, out, err, wait_thread = Open3.popen3(command)
        stdin.close
        child_pid = wait_thread.pid
            
        out_msg = out.gets()
        err_msg = err.gets()
               
        return status, out_msg, err_msg
      else
        return false, "Windows only, sorry"
    end
  end
  
  def startCMServer
    if "mingw32" == OS || "mingw64" == OS#
      service = 'Serena_Dimensions_Listener_Service'
      status, out_msg, err_msg = startWinService(service)
      
      if out_msg
       if out_msg.scan("started successfully")
         status = true
         status_msg = out_msg
       end
      end
      if err_msg
       if err_msg.scan("alread successfully")
         status = true
         status_msg = err_msg
       end
      end
          else
      puts "TODO: UNIX CM start"
    end
    return status, status_msg
  end
  
  def startSCTomcat
    if "mingw32" == OS || "mingw64" == OS
      service = 'SerenaTomcat'
      status, out_msg, err_msg = startWinService(service)
      
      if out_msg
       #puts "OUT: " + outmsg
       if out_msg.scan("started successfully")
         status = true
         status_msg = out_msg
       end
      end
      if err_msg
       #puts "ERR: " + err_msg
       if err_msg.scan("alread successfully")
         status = true
         status_msg = err_msg
       end
      end
    else
      puts "TODO: UNIX service start"
    end
    
    return status, status_msg
  end

end

# __FILE__ hard coded to this file
# if argv[0] is this file, I'm being run standalone
# execute the following lines:
if __FILE__ == $0
  s = ALMServices.new
  
  ret, msg = s.startSCTomcat
  
  if ret
    puts "TOMCAT Success: " + String(msg)
  else
    puts "TOMCAT Failed: " + String(msg)
  end
  
  ret, msg = s.startCMServer
  
  if ret
    puts "CM Success: " + String(msg)
  else
    puts "CM Failed: " + String(msg)
  end
end
  
  