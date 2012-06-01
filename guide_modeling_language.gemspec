Gem::Specification.new do |s|
  s.name         = "guide_modeling_language"
  s.version      = '0.2.2'
  s.platform     = Gem::Platform::RUBY  
  s.description  = "Zorgblik Guide Modeling Language"
  s.summary      = "Medical guide DSL models and modeling methods; assumes MongoMapper gem"
  s.author       = 'Zorgblik'
  s.email        = 'developer@zorgblik.nl'
  s.homepage     = 'http://zorgblik.nl'  
  s.require_path = 'lib'
  s.required_rubygems_version = ">= 1.8.x"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  s.test_files   = `git ls-files`.split("\n").select{|f| f =~ /_test\.rb$/}
  
  s.add_dependency "railties", "~> 3.0"
  s.add_dependency "mongo_mapper"  
  
end