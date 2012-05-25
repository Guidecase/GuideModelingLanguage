Gem::Specification.new do |s|
  s.name         = "guide_modeling_language"
  s.version      = '0.1.0'
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
end