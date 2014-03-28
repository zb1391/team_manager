class SummerCamper < ActiveRecord::Base
	belongs_to :summer_camp

	validates :first_name, :last_name, 
		:address, :city,:state,:zip,
		:gender,:grade,
		:email, :home_phone,:cell_phone,
		:waiver_name, :waiver_date,
		presence: true
	validates :home_phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validates :cell_phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validate :unique_name, :on => :create
	before_create :initial_pay_values
	before_create :amount_owe_setup

	def unique_name
		already_a_row = SummerCamper.where("summer_camp_id = ? AND last_name = ? AND first_name = ? AND grade = ?",
			summer_camp_id,last_name,first_name,grade).to_a
		if !already_a_row.empty?
			errors.add(:first_name, " - #{first_name} #{last_name}, #{grade} grade, has already registered for the Summer Camp
				#{summer_camp.date_range}")			
		end

	end


	private

	def initial_pay_values
		if self.amount_paid.nil?
			self.amount_paid = 0
		end
	end

	def amount_owe_setup
		self.amount_owe = summer_camp.price
	end
end
