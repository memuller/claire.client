require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class Video
	include Claire::Client::Item
	include Claire::Client::Listable	
end

describe Claire::Client::Listable do
  before do
    Claire::Client.stub(:get).with('videos').and_return xml(:item_with_channel)
		Claire::Client.stub(:get).with('videos/id').and_return xml(:item)
  end

	describe "initialization" do
		it "should work only on Claire::Items" do
		  lambda { eval("
				class NotAVideo
					include Claire::Client::Listable
				end
			") }.should raise_error Claire::Error
			lambda { Video.new('id')}.should_not raise_error
		end				
	end
	
	describe "its all method" do
		it "should be defined" do
			Video.should respond_to :all
		end
		
		it "should return a Claire::List on the item's base URL" do
		  Video.all.should be_a_kind_of Claire::Client::List
		end
	end
	
	it "delegate a count property to its all method" # do
	 # 		Video.count.should == 2
	 # 	end                                             
	
	it "should have a list of its children" do
	  Claire::Client::Listable.children.include?(Video).should be_true
	end
	
	it "should accept a block filter" do
		Video.all { |video| video.title }.should_not be_empty
		Video.all { |video| video.title == ''}.should be_empty
	end
	

end