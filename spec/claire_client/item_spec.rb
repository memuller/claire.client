require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class Video
	include Claire::Client::Item
end

describe Claire::Client::Item do
	#@session.should_receive(:post).with("url", "data", "headers")
	#@session = mock("session")
	before do 
		Claire::Client.stub(:get).with('videos/id').and_return xml :item
		@video = Video.new(hash_from_xml(:item))
	end
	
	describe "its initializer" do
		
		describe "its base_url class attribute" do
			it "should default to the class name, pluralized" do
				Video.base_url.should == "videos"			
			end
			
			it "should accept manual overwrite on the class" do
				Video.base_url = "lists"
				Video.base_url.should == "lists"
				Video.base_url = nil
				Video.base_url.should == "videos"
			end
			
			it "if the class is in a module, it should get the class name only" do
				eval %(
					module Testing
						class Video
							include Claire::Client::Item
						end
					end
				)
				Testing::Video.base_url.should == "videos"
			end
		end
		
		context "upon receiving a Hash" do
			before :each do				
				@video = Video.new(hash_from_xml(:item))
			end
			
			it "should set partial do true" do
				@video.should be_partial
			end
			
			it "should skip the <rss> container if it is present" do
				@video.title.should be_a_kind_of String
				@video.should_not respond_to :rss
			end
			
			it "should skip the <channel> container if its present" do
				video = Video.new(hash_from_xml(:item_with_channel))
				video.title.should be_a_kind_of String
				video.should_not respond_to :channel
			end
			
			it "should never set 'items' attributes " do
				%w(item item_with_channel).each do |type|
					video = Video.new(hash_from_xml(type))
					video.should_not respond_to :item
					video.title.should be_a_kind_of String
					
				end
			end
			
			it "should set the link attribute properly (eg ignoring links to other objects/pages)" do
				video = Video.new hash_from_xml :item_with_channel
				video.link.should be_a_kind_of String								
			end											
				
			it "should set its key/values as properties of the element" do
				%w(title link category keywords description).each do |item|
					@video.send(item).should be_a_kind_of String
				end
				%w(thumbnail content).each{ |item|  @video.send(item).should be_a_kind_of Array }
			end
			it "should fail if there is not a link attribute" do
				lambda { Video.new( {:rss => {:item => {:name => 'bla'}}} ) }.should raise_error Claire::Error
			end
		end
		
		context "upon receiving a String" do
			before { @video = Video.new 'id' }
			it "should open the given string" do
				lambda { Video.new "" }.should raise_error
				lambda { Video.new "id" }.should_not raise_error
			end
			it "should parse the result using the XML parsing rules" do
				@video.title.should be_a_kind_of String 
			end
			it "should set partial to false" do
				@video.should_not be_partial
			end
			
		end		
				 								
	end
	
	describe "its comparison (spaceship) operator" do		
		it "should be defined" do
			@video.should respond_to '<=>'		   
		end
		
		it "should compare items by title" do
		  @video2 = @video.clone
			(@video <=> @video2).should be 0
		end
		
	end
	
	context "when an undefined method is called" do
		it "it should raise error if partial is false"
		context "if the item is partial" do
			it "should request the full object from server, and replace itself"
			it "should return the asked attribute"
		end
	end	
	
	it "should have a list of its children as the children class attribute" do
		Claire::Client::Item.children.include?(Video).should be true
	end
	
	
end