#loads global dependencies
#%w(rubygems mongo mongo_mapper memcache yaml activesupport json).each{|lib| require lib}

#loads every ruby file inside those folders
	full_dir = File.expand_path(File.join(File.dirname(__FILE__), 'claire_client'))
  Dir.new(full_dir).entries.each do |file|
      load [full_dir, file]*'/' if file.include? '.rb'
  end

#main module here.
module Claire
	module Client
		%w(rubygems open-uri active_support hashie).each { |lib| require lib }
		@@hostname = "localhost:3000"
		@@api_key = "33c80d2e38e6b1753982500721f76eccaee0d111"
		@@format = 'xml'
		
		%w(api_key hostname format).each do |var|
			class_eval <<-METHOD
				def self.#{var}
					@@#{var}
				end
				
				def self.#{var}= arg
					@@#{var} = arg
				end
			METHOD
		end
		
		# receives all parameters necessary for request-making.
		def self.config args={}
			args.each do |k,v|
				class_variable_set "@@#{k}", v
			end			
		end
		
		# assembles an URL from an string of params.
		def self.assemble_url url="", params={}
			url = "http://#{@@hostname}/#{url}"			
			url += ".#{@@format.downcase}" if @@format			
			uri = URI.parse url			
			(uri.query ||= "") << "api_key=#{@@api_key}"
			params.each do |k,v|
				uri.query << "&#{k}=#{v}"
			end
			uri
			
		end
		
		# gets an URL. Assembles it first.
		def self.get url=''
			url = assemble_url(url)
			request = open(url)
			return request.read if request.status.first.to_i == 200
			nil
		rescue Exception => e
			case e
			when Net::HTTP::TimeoutError
				
			end					
		end
		
		
	end
	
	
	#here goes the errors.
	class Error < StandardError; end
	class ClientError < Error; end
	class AuthError < Error; end
	class NotFound < Error; end
	class TimeoutError < Error; end

	module Client
		class Video
  		include Claire::Client::Item
		end
	end
	
end

