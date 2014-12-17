class PagesController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:dashboard]
  layout "home", only: [:home]
  caches_page :alliphones, :allipads, :help, :about, :thanksandshare, :faq, :sellerfaq, :buyerfaq, :terms
 
  
  def home
         @newlistedphones = Phone.all.order("updated_at DESC").limit(6)
         @mostviewedphones = Phone.all.order("impressions_count DESC").limit(6)
         @iphones = Phone.where('phonetype iLIKE ?', "iPhone")
         @ipads = Phone.where('phonetype iLIKE ?', "iPad")
         
  end
  
  
  def searchresults
     @phones = Phone.order(:modelname).where("modelname iLike ?", "%#{params[:search]}%").paginate :page => params[:page],:per_page=>30  
  end 
  
 
  def help
  end
  
  def about
  end
  
  def dashboard
      
    
    @user = current_user
     @listings = Listing.where('user_id = ?',@user.id).limit(50)
     @profile = Profile.where('user_id = ?',@user.id).limit(1)
     @feedbacks = Review.where('profile_id = ?',@profile.id).limit(50)
     @orders = Order.where('seller_id = ? OR user_id = ?', @user.id,@user.id).limit(50)
     @review = @profile.reviews.build
     
   
  end
  
  
  def sell
    
  end
  
  def buy
  
  end
  
  
  def listing
    @listing = Listing.find(params[:id])
    @phone = Phone.find(@listing.phone_id)
    @author = Listing.get_listing_author(@listing.user_id)
    @profile = Listing.get_listing_author_profile(@listing.user_id)
    if !params[:foo]
    @comment = @listing.comments.build
  end
    @comments = Comment.where("status like ? AND listing_id = ?", "Approved", @listing.id)
    
  end
  
  def phones
    @phones = Phone.order(:modelname).where("modelname iLike ?", "%#{params[:search]}%") 
    render json: @phones
  end
  
  def alliphones
      @phones = Phone.where("phonetype iLike ?", "iPhone") .paginate :page => params[:page],:per_page=>30
  end
  
  def allipads
      @phones = Phone.where("phonetype iLike ?", "iPad") .paginate :page => params[:page],:per_page=>30
  end
  
  def thanksandshare
   
    @url = "http://www.phonesalad.com" + session[:previous_url] + "/" + params[:lid]

  end
  
  
  def terms
  end
  
  def faq
  end
  
  def sellerfaq
  end
  
  def buyerfaq
  end
  
end
