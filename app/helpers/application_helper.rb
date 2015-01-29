require 'date'

module ApplicationHelper
	def link_to_add_fields(name, f, association, options={})
	    new_object = f.object.send(association).klass.new
	    id = new_object.object_id
	    fields = f.fields_for(association, new_object, child_index: id) do |builder|
	      render(association.to_s.singularize + "_fields", f: builder)
	    end
	    link_to(name, '#', id: "add-teams-button", class: "add_fields "+(options[:class]||''), data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_dynamic_preview_fields(name, f, association, options={})
	    new_object = f.object.send(association).klass.new
	    id = new_object.object_id
	    fields = f.fields_for(association, new_object, child_index: id) do |builder|
	      render(association.to_s.singularize + "_fields", f: builder)
	    end
	    link_to(name, '#', class: "dynamic_preview_creator"+(options[:class]||''), data: {id: id, fields: fields.gsub("\n", "")})
  end
end

# module ActionView
# 	module Helpers
# 		module FormOptionsHelper
# 			def data_collection_select(object, method, collection, value_method, text_method, options = {}, html_options = {})
# 				Tags::DataCollectionSelect.new(object, method, self, collection, value_method, text_method, options, html_options).render
# 			end
# 		end

# 		class FormBuilder
# 			def data_collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
# 				@template.data_collection_select(@object_name, method, collection, value_method, text_method, objectify_options(options), @default_options.merge(html_options))
# 			end 

# 		end

# 		module Tags
# 			class DataCollectionSelect < ActionView::Helpers::Tags::CollectionSelect
#         def initialize(object_name, method_name, template_object, collection, value_method, text_method, options, html_options)
#           super(object_name, method_name, template_object, collection, value_method, text_method, options, html_options)
#         end

# 				def render
# 					binding.pry
# 					super
# 				end
# 			end
# 		end

# 	end
# end


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
