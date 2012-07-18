class HealthCheck    
  attr_accessor :product, :area, :passfail, :resultsummary;
  
  def initialize(product, area, passfail, resultsummary)
    @product = product;
    @area = area;
    @passfail = passfail;
    @resultsummary = resultsummary;
  end
end
