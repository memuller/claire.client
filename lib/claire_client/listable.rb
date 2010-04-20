module Claire
	module Client
		module Listable
					 						
			module ClassMethods
				
				# Returns a Claire::List on its base_url.
				# if passed a block, gets the list, them applies a local 
				# filter to the received items, returning an Array.				
				def all &block					
					list = List.new(self.base_url)
					return list unless block
					items = []					
					list.each do |item|
						items << item if yield(item)						
					end
					items		
										
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