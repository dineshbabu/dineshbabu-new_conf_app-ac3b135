class OracleDatabaseDetails < ConnectionDetails
    include ActiveModel::Validations
    include ActiveModel::Conversion
  
    attr_accessor :adminUser, :adminPassword;
  
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
