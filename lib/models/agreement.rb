class Agreement
  include MongoMapper::EmbeddedDocument
  
  key :confirmations, Array
end