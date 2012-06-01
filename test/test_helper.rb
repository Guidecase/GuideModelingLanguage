require 'test/unit'
require '../lib/guide_modeling_language.rb'

class Guide
  include Guidecase::DSL

  attr_accessor :_id, :slug, :version, :summary, :agreement
  attr_accessor :groups, :diagnoses, :complaints, :outcomes

  def initialize
    @groups = []
    @diagnoses = []
    @complaints = []
    @outcomes = []
  end  
  
  def instance_test_method
    true
  end  
end

class Agreement
  attr_accessor :_id, :confirmations
    
  def initialize(params)
    self._id = params[:_id]
    
    @confirmations = []
  end
end

class Group
  attr_accessor :_id, :questions
  
  def initialize(*args)
    @questions = []
  end
end

class Question
  attr_accessor :_id, :image, :explanation, :required, :reply
  attr_accessor :answers, :alerts, :conditions
  
  def initialize(params={})
    self._id = params[:_id]
    self.reply = params[:reply]
    
    @alerts = []
    @answers = []    
    @conditions = []        
  end
end

class Diagnosis
  attr_accessor :_id, :symptoms, :disease, :description, :low_risk
  
  def initialize(params={})
    self._id = params[:_id]
    @symptoms = []
  end
end

class Outcome
  attr_accessor :_id, :urgency, :recommendation, :sick_days
  attr_accessor :conditions, :headings, :paragraphs, :tips, :indicators
  
  def initialize(params={})
    self._id = params[:_id]
    self.urgency = params[:urgency]
    
    @conditions = []
    @headings = []
    @paragraphs = []
    @tips = []
    @indicators = []
  end
end