module Claire
  module Client
    module Item						
			
			attr_writer :partial
			
    	def initialize arg
    		if arg.is_a? String
    			file = Claire::Client.get("#{self.class.base_url}/#{arg}")
					if Claire::Client.format == 'xml'
						hash = Hashie::Mash.new(Hashie::Mash.from_xml(file))
					else
						hash = Hashie::Mash.new(JSON.parse(file))
					end
					@partial = false
			 	else 
					hash = Hashie::Mash.new(arg) and @partial = true
				end
				
				# fetches items from rss, channel, or directly?
				if hash.rss
					hash = hash.rss
					hash = 	if hash.channel
										then	hash.channel
										else  hash.item
									end
				end
										
				hash.each do |k,v|
					
					# skips paging and sub-items.
					next if %w(item next previous).include? k
					
					# sets an element's label										         										
					v = v.label if v.respond_to?('merge') and not v.label.nil?
					
					# properly fetches the items's link, in case there are more than one link
					v = v.first if k == 'link' and v.respond_to? 'push'
					
					class_eval "def #{k}; @#{k}; end" 
					instance_variable_set "@#{k}", v
				end
				
				# a link is always required. 
				raise Claire::Error, "a link is always required" if @link.nil? or @link.empty?
								
    	end
      
			# comparison operator. Sorts by title.
			def <=> arg
				criteria = :title 
				return 1 if self.send(criteria) > arg.send(criteria)
				return 0 if self.send(criteria) == arg.send(criteria)
				return -1 if self.send(criteria) < arg.send(criteria) 				
			end
			
			# checks an item's partial status
      def partial?
      	@partial
      end

			module ClassMethods
				
				# Returns this class base URI on the server,
				# or guesses it from this class name.
				def base_url
					if defined? @@base_url
						return @@base_url unless @@base_url.nil?
					end															
					self.to_s.downcase.pluralize.split('::').last					
				end
			  
				# Manually set this class base URI on the server. 
				def base_url= arg
					@@base_url = arg
				end
			end			
			
			# Extends the class methods above.
			def Item.included base
				base.extend ClassMethods
				(@@children ||= []) << base
			end
			
			# Lists all avaliable Claire::Items			
			def self.children
				@@children ||= []
			end
						
    end
  end
end
