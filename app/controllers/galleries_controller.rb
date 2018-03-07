class GalleriesController < ApplicationController
#This Class is all about to calculate the traffic of gallery

#Method for display landing page where user can upload a file
#Created by Varun
#Date = 7-3-18

  def new
    
  end
  	
#Method for sowing a result
#Created by Varun
#Date = 7-3-18

  def display
  	unless params[:log_file].present? 	
  		redirect_to "/"
  		flash[:error] = "Please upload a file"
    else
    	traffic = Gallery.gallery_visit params
    	@gallery_traffic= traffic.sort
    end	
  end

  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
    	params.permit(:log_file)
    end
end
