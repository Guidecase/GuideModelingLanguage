class Guide
  include MongoMapper::Document
  include Guidecase::DSL

  key :slug, String
  key :image, String
  key :version, String
  key :summary, String
  
  one  :agreement
  one  :anatomy
  many :groups
  many :outcomes
  many :diagnoses
  many :complaints

  def format_id
    self._id = _id.to_s.gsub(' ', '_').downcase if _id
  end

  def questions(group=nil)
    return @questions unless @questions.nil?
     
    @questions = []
    groups.each {|g| @questions += g.questions if group.nil? || group == g._id.to_s }
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