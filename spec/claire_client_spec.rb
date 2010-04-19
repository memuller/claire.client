require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe Claire::Client do
	before { Claire::Client.stub(:get).with('categories').and_return(xml(:list)) }
	
	it "should have a hostname property" do
		%w(hostname hostname=).each{ |method| Claire::Client.should respond_to method }		
	end
	it "should have an API key" do
		%w(api_key api_key=).each{ |method| Claire::Client.should respond_to method }
	end	
	it "should have a format property" do
		%w(format format=).each{ |method| Claire::Client.should respond_to method }
	end
	
	context "its config method" do
		
		it "should exist"do
			Claire::Client.should respond_to "config"
		end
		
		it "should accept an hash of init options" do
			lambda{ Claire::Client.config :api_key => "abc", :hostname => "localhost:3000"}.should_not raise_error
		end
		
		it "received options must be set" do
			Claire::Client.config :api_key => "abc", :hostname => "localhost:3000"
			Claire::Client.api_key.should == "abc"
			Claire::Client.hostname.should == "localhost:3000"			
		end
		
	end
	
	it "standard errors should be defined" do
		%w(Claire::Error Claire::ClientError Claire::AuthError Claire::NotFound Claire::TimeoutError).each do |err|	
			lambda{ eval("#{err}") }.should_not raise_error 
		end
	end
	
	describe "its assemble_url method" do
		
		it "should exist" do
			Claire::Client.should respond_to "assemble_url"
		end		
		
		it "should receive a string" do
			lambda{ Claire::Client.assemble_url("url") }.should_not raise_error
		end
		
		it "should receive an optional parameter hash" do
		  lambda{ Claire::Client.assemble_url("url",{:param => 'value'}) }.should_not raise_error
		end
		
		it "should return an URI object" do
			Claire::Client.assemble_url.should be_a_kind_of URI
		end
		
		context "about the resulting URI" do
			before do 
				@response = Claire::Client.assemble_url("categories")
			end
			
			it "should have the given hostname" do
				lambda { Claire::Client.hostname.include?(@response.host) }.call.should be true				  
			end
			
			it "should use the API key" do
				@response.query.include?("api_key=#{Claire::Client.api_key}").should be true
			end
			
			it "should have the desired format" do
				lambda { @response.to_s.include?(".#{Claire::Client.format.downcase}") }.call.should be true
			end
			
			it "should have the desired path" do
				lambda { @response.path.include? "categories" }.call.should be true
			end
			
			it "should have the given query" do
				@response = Claire::Client.assemble_url("categories?stuff=true")
				lambda { @response.query.include?("stuff=true") }.call.should be true				
			end
			
			context "if a param hash was given" do
			  before :each do
			  	@response = Claire::Client.assemble_url("categories", :page =>  2, :limit => 10)			
			  end
			
				it "assembles the params in the URI" do
			    %w(limit=10 page=2).each do |i|
			    	@response.query.include?(i).should be true
			    end
			  end
			end
		
		end 
		
	end 
	                   
	describe "its get method" do
		it "should exist" do
			Claire::Client.should respond_to "get"
		end
	  
		it "should receive a String" do
			lambda { Claire::Client.get "categories" }.should_not raise_error			
		end
		
		it "should receive aditional params as an hash"		
		
		it "should make the request and return an body" do
			lambda { Claire::Client.get "categories" }.call.should_not be_empty
		end
		
	end
end
