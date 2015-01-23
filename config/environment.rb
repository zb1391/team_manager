# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
TeamManager::Application.initialize!

# Get Rid of the Field With Errors nonsense
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
	html_tag.html_safe
end