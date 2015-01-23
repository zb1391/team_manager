class Coupon < ActiveRecord::Base
	validate :title_or_description

	def self.active_coupons
		Coupon.where(active: true).reject{|coupon| !coupon.active?}
	end

	def active?
		active && Date.today <= (active_until || Date.today) 
	end

	def display_active_message
		unless active?
			"Inactive"
		else
			"Active #{active_until.blank? ? 'Indefinitely' : "until #{active_until.strftime('%m/%d/%Y')}"}"
		end
	end

	private
	def title_or_description
		if title.blank? && description.blank?
			errors.add(:title, "You must enter one")
			errors.add(:description, "You must enter one")
		end
	end
end