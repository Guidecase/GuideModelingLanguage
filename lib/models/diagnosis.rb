class Diagnosis
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :description, String
  key :disease, String
  key :weight, Float, :default => 0
  
  many :symptoms
end