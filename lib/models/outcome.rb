class Outcome
  include MongoMapper::EmbeddedDocument
  
  key :urgency, Integer
  key :summaries, Array
  key :warning, String
  key :headings, Array
  key :paragraphs, Array
  key :tips, Array
  key :indicators, Array
  key :recommendation, String
  key :sick_days, Integer, :default => 0
  
  many :conditions
end