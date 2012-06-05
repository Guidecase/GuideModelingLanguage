class Guide
  include MongoMapper::Document
  include Guidecase::DSL

  key :slug, String
  key :image, String
  key :version, String
  key :summary, String
  
  one :agreement
  many :groups
  many :outcomes
  many :diagnoses
  many :complaints

  def format_id
    self._id = _id.to_s.gsub(' ', '_').downcase if _id
  end

  def questions
    q = []
    groups.each {|g| q += g.questions }
    q
  end  
end