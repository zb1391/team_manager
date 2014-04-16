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
	validate :unique_camper, :on => :create
	validate :has_one_camp
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

	def has_one_camp
		if summer_camps.empty?
			errors.add(:summer_camps, ": Please register for at least one camp")
		end
	end
	def unique_camper
		summer_camps.each do |summer_camp|
			already_a_row = SummerCamper.includes(:summer_camps).where(
				:first_name => first_name, 
				:last_name => last_name, :grade => grade,
				:summer_camps => {:id => summer_camp.id})
			if !already_a_row.empty?
			errors.add(:summer_camps, ": #{first_name} #{last_name}, #{grade} grade, has already registered 
				for the camp: #{summer_camp.date_range}")			
			end
		end
	end

end
