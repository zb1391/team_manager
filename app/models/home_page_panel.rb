class HomePagePanel < ActiveRecord::Base
	include DisplayHelper

	has_many :html_elements, dependent: :destroy

	validates :title, presence: {message: 'You must enter a title'}
	validates :additional_link, 
		presence: {message: 'Must have both a link and text'}, unless: "additional_link_text.blank?"
	validates :additional_link_text, 
		presence: {message: 'Must have both a link and text'}, unless: "additional_link.blank?"	

	after_initialize :set_default_html

	private
	def set_default_html
		self.html = "<p></p><dl></dl>" if self.html.blank?
	end
end