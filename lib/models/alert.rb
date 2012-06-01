class Alert
  include MongoMapper::EmbeddedDocument

  key :description, String
end