class PaymentNotification < ActiveRecord::Base
	belongs_to :organization
	serialize :params
	after_create :update_purchase_info

	private 

	def update_purchase_info
		if status == "Completed"
			paid = organization.amount_paid + amount
			organization.update_attribute(:amount_paid, paid)
			organization.update_attribute(:paid_at, Time.now)
		end
	end

end
