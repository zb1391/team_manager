class Club < ActiveRecord::Base
	belongs_to :organization
	validates :cell, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
end
