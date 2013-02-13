class Guide
  include MongoMapper::Document
  include Guidecase::DSL

  key :slug, String
  key :image, String
  key :version, String
  key :summary, String
  key :weight_threshold, Integer, :default => 3
  
  one  :anatomy
  many :groups
  many :outcomes
  many :diagnoses
  many :complaints

  cattr_accessor :questions
  class << self
    def load_question_lookups
      return questions unless questions.blank?
      
      q = File.read("#{Guidecase::Guides.root}/questions.rb")
      guide = Guide.new
      guide.group :common
      guide.receiver = guide.groups.first
      guide.instance_eval(q)
      self.questions = guide.groups.first.questions || []
    end
    
    def lookup_question(key)
      load_question_lookups if questions.nil?
      questions.select{ |q| q._id == key}.first
    end
  end  

  def format_id
    self._id = _id.to_s.gsub(' ', '_').downcase if _id
  end

  def questions(group=nil)
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