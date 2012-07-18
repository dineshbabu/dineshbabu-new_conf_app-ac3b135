class TypicalStreamDevelopment
    
  include ActiveModel::Validations
  attr_accessor :osLoginId, :areaOwnerId, :password, :processModelDirectory
  validates :osLoginId, :length => { :minimum => 3 }
  
  def initialize(*typicalStreamDevelopment)
    if(typicalStreamDevelopment.length == 1)
      @osLoginId = typicalStreamDevelopment[0][:osLoginId];
      @areaOwnerId = typicalStreamDevelopment[0][:areaOwnerId];
      @password = typicalStreamDevelopment[0][:password];
      @processModelDirectory = typicalStreamDevelopment[0][:processModelDirectory];
    end    
  end
  
  #added this method because otherwise it throws method not founnd error
  def to_key
    self.keys.to_a
  end

  #added this method because otherwise it throws method not founnd error
  def keys
  end
 
end
