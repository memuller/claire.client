require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Claire::Client::List do

	before do
		Claire::Client.stub(:get).with('categories').and_return(xml(:item_with_channel))		
	  @list = Claire::Client::List.new('categories')
	end
	
	describe "its initializing methods & states" do
		it "should require a String" do
			lambda { Claire::Client::List.new }.should raise_error ArgumentError
			lambda { Claire::Client::List.new('categories') }.should_not raise_error
		end
		
		it "should make the response accessible thru the body property" do
			@list.body.should be_a_kind_of String
		end
		
		
		it "should have a parsed document accessible thru the document property" do
			@list.document.should respond_to '[]'
		end
																
	end
	
	describe "its each method" do
		
		it "should return an array" do
			@list.each.should respond_to :first
		end
		
		it "should accept a block, yielding once for each object" do
			i = 0 and arr = []
			@list.each do |item|
				item.should_not be_nil
				i += 1
			end
			i.should == 2
			arr.each_slice(2){ |a| a.first.should_not == a.last }
		end
		
		it "should contain a list of Claire::Client:Itens-based objects" do			
			@list.each do |item|												
				Claire::Client::Item.children.include?(item.class).should be true				
			end
		end
		
		it "the returned objects should be set as partial" do
			@list.each { |item| item.should be_partial } 
		end									
	end
	
	describe "its size method" do
		it "should return the nun_items field if its avaliable"
		it "should count the items if otherwise"
	end
	
		  
end
