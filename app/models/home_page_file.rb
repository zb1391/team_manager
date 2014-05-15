class HomePageFile < ActiveRecord::Base

	has_attached_file :the_file
validates_attachment :the_file, :presence => true,
  :content_type => { :content_type => "application/pdf" },
  :on => :create
end
