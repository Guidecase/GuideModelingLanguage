namespace :db do
  desc "Seed the MongoDB guide collection from DSL files"
  task :seed => :environment do
    guide_path = Guidecase::Guides.root # TODO remove implicit guides gem dependency

    head_guide = Guide.evaluate(File.read("#{guide_path}/head_pain.rb"))
    throat_guide = Guide.evaluate(File.read("#{guide_path}/sore_throat.rb"))
    cough_guide = Guide.evaluate(File.read("#{guide_path}/cough.rb"))
    
    head_guide.save
    throat_guide.save
    cough_guide.save
  end
end