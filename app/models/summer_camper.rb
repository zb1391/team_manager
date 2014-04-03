class SummerCamper < ActiveRecord::Base
	attr_accessor :manual_fee_entry

	has_many :campifications
	has_many :summer_camps, :through => :campifications
	accepts_nested_attributes_for :campifications
	
	validates :first_name, :last_name, 
		:address, :city,:state,:zip,
		:gender,:grade,
		:email, :home_phone,:cell_phone,
		:waiver_name, :waiver_date,
		presence: true
	validates :home_phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validates :cell_phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	before_create :initial_pay_values


	private

	def initial_pay_values
		if self.amount_paid.nil?
			self.amount_paid = 0
		end
	end

	def amount_owe_setup
		self.amount_owe = 0
		self.summer_camps.each do |summer_camp|
			self.amount_owe += summer_camp.price
		end
	end
end
