module DisplayHelper
	def list
		@list ||= HtmlList.new(self.html)
	end

	def paragraph
		@paragraph ||= HtmlElement.new('p',self.html)
	end

	class HtmlElement
		attr_accessor :text, :tag, :data_id
		
		def initialize(tag, html, data_id=0)
			self.tag = tag
			self.text = parseHtml(html)
			self.data_id = data_id
		end

		# get all content of that element
		def parseHtml(html)
			regex = /<(#{tag}(.*?)>(.*?)<\/#{tag}>)/
			results = html.scan(regex)
			return results.empty? ? '' : results[0][-1]
		end

		def generateHtmlString
			"<#{tag} data-type='#{tag}' data-id='#{data_id}'>#{text}</#{tag}>"
		end

		def renderHtmlElement
			generateHtmlString.html_safe
		end
	end


	class HtmlList < HtmlElement
		attr_accessor :list_items
		def initialize(html)
			super('dl', html)
			self.list_items = []
			self.list_items = set_list_items
		end

		def set_list_items
			list_item_regex = /(<(dt|dd)(.*?)>(.*?)(<\/\2>))/
			children = text.scan(list_item_regex)
			
			children.each_with_index do |child,i|
				list_items << HtmlElement.new(child[1],child[0],i)
			end
			list_items
		end
	end

end