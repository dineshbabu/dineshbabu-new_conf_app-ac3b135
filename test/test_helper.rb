ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end


class LintTest < ActiveModel::TestCase
  include ActiveModel::Lint::Tests 
 
   #Model to be tested for compliance 
   class Listener
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming  
    
      attr_accessor :path, :service, :user, :min, :max, :dsn, :initial, :free, :idle_timeout, :session_timeout      
      validates :service, :user, :min, :max, :dsn, :initial, :free, :idle_timeout,:session_timeout, presence: true
        
      def initialize(attributes = {})
        attributes.each do |name, value|
          send("#{name}=", value)
        end
      end
       
      def persisted?
        false;
      end     
      
      #Start test code
      def to_model
        self
      end
   
      def valid?()      true end
      def new_record?() true end
      def destroyed?()  true end
   
      def errors
        obj = Object.new
        def obj.[](key)         [] end
        def obj.full_messages() [] end
        obj
      end
      #End test code
    end
  
    def setup
      @model = Listener.new
    end
end