class Condition
  include MongoMapper::EmbeddedDocument
  
  key :answers, Array
end