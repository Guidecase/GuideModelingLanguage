class Answer
  include MongoMapper::EmbeddedDocument
  
  key :explanation, String  
  key :image, String
end