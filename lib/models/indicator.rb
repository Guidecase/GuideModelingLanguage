class Indicator
  include MongoMapper::EmbeddedDocument
  
  many :conditions
end