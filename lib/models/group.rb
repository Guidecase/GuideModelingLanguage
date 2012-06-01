class Group
  include MongoMapper::EmbeddedDocument
  
  many :questions
end