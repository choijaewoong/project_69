class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :predefined_variables 
  
  def predefined_variables 
    
    @CATEGORY_NAME = ["78", "18", "4", "100"]
    
    @COLOR_ARRAY = ["#EE3C39",
                    "#50266B",
                    "#094A78",
                    "#F16624", 
                    "#006040",
                    "#552B0F",
                    "#2D2D2D"]
                    
    @board_show_count = 20
    
  end
end
