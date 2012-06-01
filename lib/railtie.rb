class Railtie < Rails::Railtie
  rake_tasks do
    rake_files = Dir[ File.join(File.dirname(__FILE__),'tasks/*.rake') ]
    rake_files.each { |file| load file }
  end
end