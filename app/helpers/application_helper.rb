require 'date'

module ApplicationHelper
	def link_to_add_fields(name, f, association, options={})
	    new_object = f.object.send(association).klass.new
	    id = new_object.object_id
	    fields = f.fields_for(association, new_object, child_index: id) do |builder|
	      render(association.to_s.singularize + "_fields", f: builder)
	    end
	    link_to(name, '#', id: "add-teams-button", class: "add_fields button-look "+(options[:class]||''), data: {id: id, fields: fields.gsub("\n", "")})
  	end
end


class Date
	def season
		day_hash = month*100+mday
		case day_hash
		when 101..401 then 'Winter'
		when 402..630 then 'Spring'
		when 701..930 then 'Summer'
		when 1001..1231 then 'Fall'
		end
	end
end
