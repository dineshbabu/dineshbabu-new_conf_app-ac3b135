class FilesController < ApplicationController
  include FilesHelper
  
    Service = "-service"
    User = "-user"
    Min = "-min"
    Max = "-max"
    Dsn = "-dsn"
    Initial = "-initial"
    Free = "-free"
    Idle_timeout = "-idle_timeout"
    Session_timeout = "-session_timeout"   
  
    #GET files/home
    def home
        session[:subNavName] = "home";
        session[:header] = "Home";
        render :text => "", :layout => true;
    end
    
    #GET files/cm . Link not in use as we are taking the user directly to home page. This method can be deleted
    #def cm
    #    session[:subNavName] = "cmSubNav";
    #    session[:header] = "CM Configuration";
    #    render :text => "", :layout => true;
    #end
    
    #GET files/tomcat
    #def tomcat
    #    session[:subNavName] = "tomcatSubNav";
    #    session[:header] = "Serena Common Tomcat";
    #    render :text => "", :layout => true;
    #end
    
    #GET files/edittomcathome
    def edit_tomcat_home
      session[:subNavName] = "tomcatSubNav";
      session[:header] = "Serena Common Tomcat";
      dmr = GetRoots.new
      @sctRoot = dmr.getSCTRoot      
    end
    
    #GET files/alm
    #def alm
    #    session[:subNavName] = "almSubNav";
    #    session[:header] = "ALM Configuration Home";
    #    render :text => "", :layout => true;
    #end
    
    #GET files/editalmsinglesignon
    def edit_alm_single_sign_on
        #session[:subNavName] = "almSubNav";
        #session[:header] = "Serena Common Tomcat";
        #get_tomcat_home
        #render :text => "", :layout => true;
    end
    
    #GET files/editalmhome
    def edit_alm_home
        session[:subNavName] = "almSubNav";
        session[:header] = "ALM Configuration Home";
        dmr = GetRoots.new
        @almRoot = dmr.getALMRoot        
    end
    
    #GET files/editcmhome
    def edit_cm_home
        session[:subNavName] = "cmSubNav";
        session[:header] = "CM Configuration";
        dmr = GetRoots.new
        @cmRoot = dmr.getCMRoot
    end
    
    def start_tomcat_listener
      s = ALMServices.new  
      msg = s.startSCTomcat      
      render :text =>  msg      
    end
    
    
    def start_cm_listener
      s = ALMServices.new  
      msg = s.startCMServer
      render :text =>  msg
    end
    
    # GET /files/editlistener
    def edit_listener
        #session[:subNavName] = "cmSubNav";
        #@filePath = "C:\\Program Files\\Serena\\Dimensions 12.2\\CM\\dfs\\listenerCopy.dat"
        @filePath = "C:\\listener.dat"
        @listener = Listener.new()
        #@listener.path = @filePath; 
        File.open(@filePath) do |file|
            while content = file.gets
                if content.match(/^#/)
                    next
                end      
                @tempContent = content.split(" ");
                case @tempContent[0]
                when Service
                    @listener.service = @tempContent[1] 
                when User
                    @listener.user = @tempContent[1]
                when Min
                    @listener.min = @tempContent[1]
                when Max
                    @listener.max = @tempContent[1]
                when Dsn
                    @listener.dsn = @tempContent[1]
                when Initial
                    @listener.initial = @tempContent[1]
                when Free
                    @listener.free = @tempContent[1]
                when Idle_timeout
                    @listener.idle_timeout = @tempContent[1]
                when Session_timeout
                    @listener.session_timeout = @tempContent[1]
                end 
            end      
            file.close
        end
        render :edit_listener
    end
  
    # POST /files/updatelistener
    def update_listener
      dmr = GetRoots.new
      @cmRoot = dmr.getCMRoot
      #@filePath = "C:\\Program Files\\Serena\\Dimensions 12.2\\CM\\dfs\\listenerCopy.dat"
      @filePath = @cmRoot + "\\listener.dat"
      @listener = Listener.new(params[:listener])
      @message = "listener.dat updated successfully.";
      
      if !@listener.valid?
        render :edit_listener;
      else
        @tempcontentnew = ""
        @tempcontentnew =  Service + "  " + @listener.service + "\n"
        @tempcontentnew = @tempcontentnew + User + "  " + @listener.user + "\n"
        @tempcontentnew = @tempcontentnew + Min + "  " + @listener.min + "\n"
        @tempcontentnew = @tempcontentnew + Max + "  " + @listener.max + "\n"
        @tempcontentnew = @tempcontentnew + Dsn + "  " + @listener.dsn + "\n"
        @tempcontentnew = @tempcontentnew + Initial + "  " + @listener.initial + "\n"
        @tempcontentnew = @tempcontentnew + Free + "  " + @listener.free + "\n"
        @tempcontentnew = @tempcontentnew + Idle_timeout + "  " + @listener.idle_timeout + "\n"
        @tempcontentnew = @tempcontentnew + Session_timeout + "  " + @listener.session_timeout
        
        File.open(@filePath, 'w') do |file|
          file.write(@tempcontentnew)
          file.close
        end
        render :message
      end    
    end 
    
    # GET /files/databasemanagement
    def database_management
    end
  
    # GET /files/edittypicalstreamdevelopment
    def edit_typical_stream_development
      @typicalStreamDevelopment = TypicalStreamDevelopment.new
      @typicalStreamDevelopment.osLoginId = 'dmsys'; 
      @typicalStreamDevelopment.areaOwnerId = 'dmsys';
      @typicalStreamDevelopment.password = '';
      @typicalStreamDevelopment.processModelDirectory = 'c:\\Serena_Workareas';
      render :layout => false
    end
    
    # POST /files/updatetypicalstreamdevelopment
    def update_typical_stream_development
      @message = "Database created successfully.";
     
      @typicalStreamDevelopment = TypicalStreamDevelopment.new(params[:typical_stream_development])
      
      respond_to do |format|
        #if @post.save
         # format.html 
          #format.js 
        #else
          format.html { render :action => 'edit_typical_stream_development' }
          format.js   { render 'update_typical_stream_development.js.erb' }
          #format.json { render json: @typicalStreamDevelopment }
        #end
      end
    end
    
    # GET /files/healthcheck
    def show_health_check
      @installations = ["All", "CM", "SBM", "DVM"];
    end
  
    # POST /files/dohealthcheck
    def do_health_check
        @checkFor = params[:installations];
        
        respond_to do |format|
            begin
                if (@checkFor.nil? || @checkFor.size == 0)
                  raise "Please select at least one installed component to test."
                else
                    #if @checkFor.include?("CM")            
                    if (@checkFor.size != 0)
                        @healthCheckResult = [];
                        @healthCheckResult[0] = HealthCheck.new("CM", "Deployment", "Failed", "dmdba cm_typical/cm_typical@BAD_DSN. Dimensions CM DBA 12.1 FT1(Development) at 18:02:11 Friday 25th May 2012. Copyright(c) 1988-2011 Serena Software, Inc. All rights reserved. ");
                        @healthCheckResult[1] = HealthCheck.new("CM", "Email", "Passed", " Email check success. ");
                        @healthCheckResult[2] = HealthCheck.new("CM", "Scheduler", "Passed", " Scheduler check success. ");    
                        for i in 3..19
                          @healthCheckResult[i] = HealthCheck.new("CM", "listener", "Passed", " Listener check success. ");
                        end
                        
                        format.html { render :action => 'show_health_check' };
                        format.js   { render 'update_health_check.js.erb' };
                    else        
                        format.html { render :action => 'show_health_check' };
                    end
                end
            rescue => e
                @error = e.message;
                format.js   { render 'update_health_check.js.erb' };
            end        
        end
    end
 
    #GET /files/editconnectiondetails
    def edit_connection_details
        @connectionDetails = ConnectionDetails.new();
        @connectionDetails.databaseInstances = ["Oracle" , "SQL Server"];
        @connectionDetails.databaseLocation = ["Local" , "Remote"];
        @connectionDetails.oracleInstances = ["DIM11D" , "DIM11T" , "DIM11P"];
        @connectionDetails.sqlServerInstances = ["SQDIM11D" , "SQDIM11T" , "SQDIM11P"];
        render layout: false;
    end
    
    #POST /files/updateconnectiondetails
    def update_connection_details
    end
    
    #GET '/files/displaydatabases'    
    def display_databases
      @databases = ["CM_TYPICAL", "INTERMEDIATE", "DVM_SAMPLE", "*TESTDBX"];
      render layout: false;
    end 
 
end