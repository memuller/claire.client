$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'claire_client'
require 'spec'
require 'spec/autorun'

$root = File.join(File.dirname(__FILE__), '..')

Spec::Runner.configure do |config|
  
end

def xml arg
	 File.open("#{$root}/spec/fixtures/#{arg}.xml", 'r').read
end

def hash_from_xml arg
	Hashie::Mash.from_xml(xml(arg))
end            