# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{claire_client}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matheus E. Muller"]
  s.date = %q{2010-04-20}
  s.description = %q{This gem is a Ruby client for the St. Claire Media Server, which power power Canção Nova's reach of video and streamming web services.}
  s.email = %q{hello@memuller.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/claire_client.rb",
     "lib/claire_client/category.rb",
     "lib/claire_client/item.rb",
     "lib/claire_client/list.rb",
     "lib/claire_client/listable.rb",
     "lib/claire_client/stream.rb",
     "lib/claire_client/video.rb",
     "spec/claire_client/item_spec.rb",
     "spec/claire_client/list_spec.rb",
     "spec/claire_client/listable_spec.rb",
     "spec/claire_client_spec.rb",
     "spec/fixtures/item.xml",
     "spec/fixtures/item_direct.xml",
     "spec/fixtures/item_with_channel.xml",
     "spec/fixtures/list.xml",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/memuller/claire.client}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A ruby client for St. Claire.}
  s.test_files = [
    "spec/claire_client/item_spec.rb",
     "spec/claire_client/list_spec.rb",
     "spec/claire_client/listable_spec.rb",
     "spec/claire_client_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_runtime_dependency(%q<hashie>, [">= 0.2.0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_dependency(%q<hashie>, [">= 0.2.0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.5"])
    s.add_dependency(%q<hashie>, [">= 0.2.0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

