class Symptom
  include MongoMapper::EmbeddedDocument
  
  key :answers, Array
  key :weight, Float, :default => 1
end