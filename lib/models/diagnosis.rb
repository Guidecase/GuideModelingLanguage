class Diagnosis
  include MongoMapper::EmbeddedDocument
  
  key :description, String
  key :disease, String
  key :low_risk, Boolean, :default => false
  
  many :symptoms
end