class DmconfsController < ApplicationController
  
  Service = "-service"
  User = "-user"
  Min = "-min"
  Max = "-max"
  Dsn = "-dsn"
  Initial = "-initial"
  Free = "-free"
  Idle_timeout = "-idle_timeout"
  Session_timeout = "-session_timeout" 

  
  # GET /dmconfs
  # GET /dmconfs.json
  def index
    @dmconfs = Dmconf.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dmconfs }
    end
  end

  # GET /dmconfs/1
  # GET /dmconfs/1.json
  def show
    @dmconf = Dmconf.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dmconf }
    end
  end

  # GET /dmconfs/new
  # GET /dmconfs/new.json
  def new
    @dmconf = Dmconf.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dmconf }
    end
  end

  # GET /dmconfs/1/edit
  def edit
    @filePath = "C:\\Program Files\\Serena\\Dimensions 12.2\\CM\\dfs\\listenerCopy.dat"
    @dmconf = Dmconf.new
    @dmconf.path = @filePath; 
    File.open(@filePath) do |file|
      while content = file.gets
        if content.match(/^#/)
          next
        end      
        @tempContent = content.split(" ");
        case @tempContent[0]
        when Service
           @dmconf.service = @tempContent[1] 
        when User
           @dmconf.user = @tempContent[1]
        when Min
           @dmconf.min = @tempContent[1]
        when Max
           @dmconf.max = @tempContent[1]
        when Dsn
           @dmconf.dsn = @tempContent[1]
        when Initial
           @dmconf.initial = @tempContent[1]
        when Free
           @dmconf.free = @tempContent[1]
        when Idle_timeout
           @dmconf.idle_timeout = @tempContent[1]
        when Session_timeout
           @dmconf.session_timeout = @tempContent[1]
        end 
      end      
      file.close
    end
  end

  # POST /dmconfs
  # POST /dmconfs.json
  def create
    @filePath = "C:\\Program Files\\Serena\\Dimensions 12.2\\CM\\dfs\\listenerCopy.dat"
    @dmconf = Dmconf.new(params[:dmconf])
    @tempcontentnew = ""
    puts "1"
    @tempcontentnew =  Service + "  " + @dmconf.service + "\n"
    puts "2"
    @tempcontentnew = @tempcontentnew + User + "  " + @dmconf.user + "\n"
    @tempcontentnew = @tempcontentnew + Min + "  " + @dmconf.min + "\n"
    @tempcontentnew = @tempcontentnew + Max + "  " + @dmconf.max + "\n"
    @tempcontentnew = @tempcontentnew + Dsn + "  " + @dmconf.dsn + "\n"
    @tempcontentnew = @tempcontentnew + Initial + "  " + @dmconf.initial + "\n"
    @tempcontentnew = @tempcontentnew + Free + "  " + @dmconf.free + "\n"
    @tempcontentnew = @tempcontentnew + Idle_timeout + "  " + @dmconf.idle_timeout + "\n"
    @tempcontentnew = @tempcontentnew + Session_timeout + "  " + @dmconf.session_timeout
    
    #@dmconf.attributes.each do |attr_name, attr_value|
    #  if ( attr_name == 'id' || attr_name == 'created_at' || attr_name == 'updated_at' || attr_name == 'path' || attr_name == 'content')
    #    next
    #  end
    #  @tempcontentnew = @tempcontentnew = "" + attr_name + "   " + attr_value
    #end
    #File.open("C:\\Program Files\\Serena\\Dimensions 12.2\\CM\\dm _copy.cfg", 'r+') {|f| f.puts(@dmconf.content.gsub("\n", ""))}
    File.open(@filePath, 'w') do |file|
      #file.puts(@dmconf.content.gsub("\n", ""))
      #file.write(@tempcontentnew.gsub("\n", ""))
      file.write(@tempcontentnew)
      file.close
    end
    #@dmconf = Dmconf.new
    #respond_to do |format|
      
      #if @dmconf.save
       # format.html { redirect_to @dmconf, notice: 'Dmconf was successfully created.' }
        #format.json { render json: @dmconf, status: :created, location: @dmconf }
     # else
      #  format.html { render action: "new" }
       # format.json { render json: @dmconf.errors, status: :unprocessable_entity }
      #end
     
      #format.html { redirect_to @dmconf, notice: 'Dmconf was successfully updated.' }
      
    #end
    #render 'dmconfs/show'
  end

  # PUT /dmconfs/1
  # PUT /dmconfs/1.json
  def update
    @dmconf = Dmconf.find(params[:id])

    respond_to do |format|
      if @dmconf.update_attributes(params[:dmconf])
        format.html { redirect_to @dmconf, notice: 'listener.dat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dmconf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dmconfs/1
  # DELETE /dmconfs/1.json
  def destroy
    @dmconf = Dmconf.find(params[:id])
    @dmconf.destroy

    respond_to do |format|
      format.html { redirect_to dmconfs_url }
      format.json { head :no_content }
    end
  end
end
