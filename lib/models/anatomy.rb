class Anatomy
  include MongoMapper::EmbeddedDocument
  
  key :image, String
  key :explanation, String
end