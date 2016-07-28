class Player < ActiveRecord::Base
  belongs_to :team

  validates :first_name,
            :last_name, 
            :phone, 
            :email,
            :parent_first_name,
            :parent_last_name,
            :parent_email, 
            :parent_cell,
            :emergency_phone, 
            :home_town, 
            :dob, 
            :team_preference,
            :grade,
            presence: true

  validates :email, 
            format: { 
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, 
              message: 'you must provide a valid email (no spaces no commas)'
            },
            allow_blank: true

  validates :parent_email, 
            format: { 
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, 
              message: 'you must provide a valid email (no spaces no commas)'
            }, 
            allow_blank: true

  validates :parent_email2, 
            format: { 
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
              message: 'you must provide a valid email (no spaces no commas)'
            }, 
            allow_blank: true

  validates :phone, 
            format: { 
              with:  /\A[0-9]+\z/, 
              message: "should only contain numbers"
            }, 
            length: {is: 10}
	
  validates :parent_cell, 
	    format: { 
              with:  /\A[0-9]+\z/, 
              message: "should only contain numbers"
            }, 
            length: {is: 10}

  validates :emergency_phone,
            format: { 
              with:  /\A[0-9]+\z/, 
              message: "should only contain numbers"
            }, 
            length: {is: 10}
	
  validate :valid_uniform_number, :on => :update

  def registered_season
    year = self.created_at.strftime("%Y")
    month = self.created_at.strftime("%m").to_i
    if(month < 5)
      "#{year}-Spring"
    elsif(month < 8)
      "#{year}-Summer"
    else
      "#{year}-Fall"
    end
  end

  def formatted_name
    format_name(self.first_name, self.last_name)
  end

  def parent_formatted_name
	format_name(self.parent_first_name, self.parent_last_name)
  end

  def format_name(first_name, last_name)
    last = last_name.slice(0,1).capitalize + last_name.slice(1..-1)
    first = first_name.slice(0,1).capitalize + first_name.slice(1..-1)
    return "#{last}, #{first}"
  end

  #No Player can have a uniform number with any digit > 5
  #Therefore the highest number a player can have is 55
  #This also confirms that the number is unique to the team
  def valid_uniform_number
    unless uniform_number.blank?
      ones_digit = uniform_number % 10
      if ones_digit == 0
        ones_digit =1;
      end
      number = Team.search(:id_eq => team_id, 
        :players_uniform_number_eq => uniform_number).result.to_a
      if !number.empty?
        errors.add(:uniform_number, "is already taken")
      end
      if uniform_number <= -1
        errors.add(:uniform_number, "can't be negative")
      end
      if uniform_number > 55
        errors.add(:uniform_number, "can't be greater than 55")
      end

      if 5 % ones_digit == 5
        errors.add(:uniform_number, "AAU Regulation: no digit greater than 5 (use numbers 0-5,10-15,20-25...)")
      end
    end
  end

  def self.GRADES
    [
      ["3rd",3],
      ["4th",4],
      ["5th",5],
      ["6th",6],
      ["7th",7],
      ["8th",8],
    ]
  end
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |player|
        csv << player.attributes.values_at(*column_names)
      end
    end
  end
end

