class CreateDb

    def create
    
        os = RbConfig::CONFIG['host_os']
        
        if 'mingw32' == os || 'mingw64' == os  
            command = "C:\\Program files\\Serena\\Dimensions 12.2\\CM\\install\\install_oracle.cmd"
            admin = 'system'
            syspwd = 'manager'
            dsn = 'dim12'
            dbname = 'cm_typical'
            toolman = 'dmsys'
            process_model = 'cm_typical'
            dmsys = 'dmsys'
            libdir = "C:\\Program files\\Serena\\Dimensions 12.2\\CM\\demo"
            user_list = 'user2 user3 user4 user5 user6'
            
            create_cmd = 'cmd /c ' + command + ' ' + admin + ' ' + syspwd + ' ' + dbname + ' ' + libdir + ' ' +
            dsn + ' ' + process_model + ' ' + dmsys + ' ' + dmsys  + ' ' + user_list
            
            puts `create_cmd`
        end
        
    end
    
end


    
    
# __FILE__ hard coded to this file
# if argv[0] is this file, I'm being run standalone
# execute the following lines:
if __FILE__ == $0
	dmr = CreateDb.new
	dmr.create
end    
    
