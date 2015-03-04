class HomePageFile < ActiveRecord::Base
	belongs_to :team
	
	has_attached_file :the_file,
					  :s3_host_name => 's3-us-west-2.amazonaws.com'
					  
	validates_attachment :the_file, :presence => true,
	  :content_type => { :content_type => "application/pdf" },
	  :on => :create

	 validates :name, uniqueness: true, presence: {message: 'cant be blank'}
end
