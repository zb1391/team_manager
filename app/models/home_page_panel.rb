class HomePagePanel < ActiveRecord::Base
	include DisplayHelper

	# has_many :html_elements, dependent: :destroy

	validates :title, presence: {message: 'You must enter a title'}
	validates :additional_link, 
		presence: {message: 'Must have both a link and text'}, unless: "additional_link_text.blank?"
	validates :additional_link_text, 
		presence: {message: 'Must have both a link and text'}, unless: "additional_link.blank?"	
	validates :priority_order, numericality: { greater_than: 0, less_than: 4}, allow_nil: true

	after_initialize :set_default_html
	before_save :set_active

	scope :active_panels, -> { where(is_active: true).order(:priority_order)}

	def self.clear_order!
		HomePagePanel.active_panels.each do |panel|
			panel.is_active = false
			panel.priority_order = nil
			panel.save(validate: false)
		end
	end

	private
	def set_default_html
		self.html = "<p></p><dl></dl>" if self.html.blank?
	end

	def set_active
		unless self.priority_order.blank?
			self.is_active = true
		end
	end
end