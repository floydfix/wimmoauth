class AppTypes < ActiveRecord::Base
  
  def self.get(type)
    case type 
    when 1
      return Foursquare.new
    when 2
      return Facebook.new
    end
  end
  
end
