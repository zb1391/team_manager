class HomePageFile < ActiveRecord::Base

	has_attached_file :the_file,
					  :url => 's3-us-west-2.amazonaws.com'
validates_attachment :the_file, :presence => true,
  :content_type => { :content_type => "application/pdf" },
  :on => :create
end
