module Claire
  module Client
    class List
			include Enumerable
			
			attr_reader :body, :document
						
			# gets, parses, and builds objects.
			def initialize(arg)
				#puts Claire::Client.respond_to? :get				
				@body = Claire::Client.get(arg)
				@document = Hashie::Mash.new(Hashie::Mash.from_xml(@body))
				@document = @document.rss if @document.rss
				@document = @document.channel if @document.channel				
				if @document.item.nil?
					@items = []
				elsif @document.item.is_a? Array
					@items = @document.item
				else					
					@items = [@document.item]
				end
				build_items											
			end						
			
			# Implements an iterator that either
			# - returns an Array of items if no block is given
			# - yields the given block once for each item
			def each &block
				return @objects unless block
				@objects.each do |obj|
					yield(obj)
				end
			end
			
			private
			
			# Builds an array of Claire media objects.
			# guesses their classes based on their restfull URI.		
			def build_items
				@items.each do |item| 					
					link = if item.link.is_a? String
						then item.link
						else item.link.first
					end
					klass = ("Claire::Client::" + link.split('/')[-2].classify).constantize
					obj = klass.new(item)
					(@objects||=[]) << obj 																		
					
				end				
				
			end

    end
  end
end
