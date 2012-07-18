class Dmconf < ActiveRecord::Base
  attr_accessor :path, :service, :user, :min, :max, :dsn, :initial, :free, :idle_timeout, :session_timeout
  attr_accessible :path, :service, :user, :min, :max, :dsn, :initial, :free, :idle_timeout, :session_timeout    
  validates :path, :service, :user, :min, :max, :dsn, :initial, :free, :idle_timeout, :session_timeout, presence: true  
end
