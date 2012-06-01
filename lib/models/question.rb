class Question
  include MongoMapper::EmbeddedDocument

  key :reply, String
  key :explanation, String 
  key :image, String
  key :required, Boolean
  
  many :answers
  many :alerts
  many :conditions
end