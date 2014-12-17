class Comment < ActiveRecord::Base
  
  belongs_to :listing, touch: true
  
  validates :commentbody, :presence => {:message => 'Heading cannot be blank, Listing not saved'}
  validates :commentbody, :length => {:maximum => 140}
  has_attached_file :picture, styles: {
      mini: '50x50>',
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }

   # Validate the attached image is image/jpg, image/png, etc
   validates_attachment_content_type :picture, :content_type => %w(image/jpeg image/jpg image/png)
  
  
 private
 def self.get_comment_count(listing_id)
 @count = Comment.where("status like ? AND listing_id = ?", "Approved", listing_id).count
 end
 
 def self.get_comment_author(comments_userid)
   @user =  User.find(comments_userid)
   @author = @newauthor  = @user.firstname
   @newauthor  = @user.firstname
   
   if @author
		@author
	else 
		@newauthor
	end

  end

  private

  def deny_to_visitors
    redirect_to root_path unless user_signed_in? or admin_signed_in?
  end
  
  
end
