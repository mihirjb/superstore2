class AssetsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
 
    private 
    def asset_params
     params.require(:asset).permit(:image_file_name, :image_file_size, :image_content_type, :image,:listing_id)
    end
end
