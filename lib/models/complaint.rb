class Complaint
  include MongoMapper::EmbeddedDocument
  
  key :image, String  
  key :description, String
  
  many :conditions  
end