class Listener
  include ActiveModel::Validations
  include ActiveModel::Conversion#Needed to make the object, Model compliant
  #extend ActiveModel::Naming
  
  attr_accessor :path, :service, :user, :min, :max, :dsn, :initial, :free, :idle_timeout, :session_timeout  
  validates :service, :user, :min, :max, :dsn, :initial, :free, :idle_timeout,:session_timeout, presence: true  
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  #Needed to make the object, Model compliant
  def persisted?
    false;
  end
  
end