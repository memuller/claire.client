module Claire
	module Client
		module Listable
					 						
			module ClassMethods
				
				# Returns a Claire::List on its base_url.
				def all					
					List.new(self.base_url)					
				end
				
			end
			
			# Extends the class methods above.
			def Listable.included base
				raise Error, "only Claire::Client::Item s can be Listable" unless Item.children.include? base
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