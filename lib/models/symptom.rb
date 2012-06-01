class Symptom
  include MongoMapper::EmbeddedDocument
  
  key :weight, Float, :default => 1
end