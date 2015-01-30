class SummerCamper < ActiveRecord::Base
	attr_accessor :manual_fee_entry

	has_many :campifications
	has_many :summer_camps, :through => :campifications
	accepts_nested_attributes_for :campifications, 
		reject_if: proc {|attributes| attributes['summer_camp_id'].blank?}
	
	validates :first_name,  presence: {message: 'You must enter a first name'}
	validates :last_name,   presence: {message: 'You must enter a last name'}
	validates :address,     presence: {message: 'You must enter a street address'}
	validates :city,        presence: {message: 'You must enter a city'}
	validates :state,       presence: {message: 'You must select a state'}
	validates :zip,         presence: {message: 'You must enter a zip code'}
	validates :gender,      presence: {message: 'You must select a gender'}
	validates :grade,       presence: {message: 'You must select a grade'}
	validates :email,       presence: {message: 'You must enter an email'}
	validates :home_phone,  presence: {message: 'You must enter a home phone number'}
	validates :cell_phone,  presence: {message: 'You must enter a cell phone number'}
	validates :waiver_name, presence: {message: 'You must sign the waiver'}
	validates :waiver_date, presence: {message: 'You must date the waiver signature'}
	validates :home_phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validates :cell_phone, format:  { with:  /\A[0-9]+\z/, message: "should only contain numbers"}, length: {is: 10}
	validate :unique_camper, :on => :create
	validate :uniqueness_of_in_memory
	validates_presence_of :campifications, message: 'You must select at least one camp'

	before_create :initial_pay_values
	before_save :calculate_amount_owe
	
	def first_last_name
		"#{first_name} #{last_name}"
	end

	def last_first_name
		"#{last_name}, #{first_name}"
	end

	private

	def calculate_amount_owe
		if manual_fee_entry == "0" || manual_fee_entry.nil?
      self.amount_owe = 0
      campifications.each do |campification|
        self.amount_owe += campification.summer_camp.price
      end
    end
	end

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
  
  def uniqueness_of_in_memory
    attrs = [:summer_camp_id]
    collection = campifications
    hashes = collection.inject({}) do |hash, record|
      key = attrs.map {|a| record.send(a).to_s }.join
      if key.blank? || record.marked_for_destruction?
        key = record.object_id
      end
      hash[key] = record unless hash[key]
      hash
    end
    if collection.length > hashes.length
      self.errors.add(:campifications, 'You cannot choose the same camp twice')
    end
  end

	def has_one_camp
		if summer_camps.empty?
			errors.add(:campifications, "You must select at least one camp")
		end
	end
	def unique_camper
		summer_camps.each do |summer_camp|
			already_a_row = SummerCamper.includes(:summer_camps).where(
				:first_name => first_name, 
				:last_name => last_name, :grade => grade,
				:summer_camps => {:id => summer_camp.id})
			if !already_a_row.empty?
			errors.add(:campifications, ": #{first_name} #{last_name}, #{grade} grade, has already registered 
				for the camp: #{summer_camp.date_range}")			
			end
		end
	end

end
