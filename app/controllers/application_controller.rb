class ApplicationController < ActionController::Base
  def hello  
   render html: "こんにちは"
  end
end
