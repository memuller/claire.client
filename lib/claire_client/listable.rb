module Claire
	module Client
		module Listable
			
			
			
			
			def Listable.included base
				base.extend ClassMethods
			end
						
			module ClassMethods
				def all
					body = get self.base_url
					List.new()					
				end
			end
			
		end
	end
end