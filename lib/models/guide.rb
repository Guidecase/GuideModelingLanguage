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
    return @questions unless @questions.nil?
     
    @questions = []
    groups.each {|g| @questions += g.questions }
    @questions
  end  
  
  def answers
    return @answers unless @answers.nil?
     
    @answers = []
    questions.each do |q|
      @answers += q.answers
    end
    @answers
  end  
  
end