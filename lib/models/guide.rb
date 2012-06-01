class Guide
  include MongoMapper::Document
  include Guidecase::DSL

  key :slug, String
  key :image, String
  key :version, String
  key :summary, String
  
  one :agreement
  many :groups
  many :outcomes
  many :diagnoses
  many :complaints
end