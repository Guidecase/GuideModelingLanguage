module Guidecase
  module DSL
    attr_accessor :receiver

    include Guidecase::DSL::GuideMethods
    include Guidecase::DSL::AgreementMethods    
    include Guidecase::DSL::OutcomeMethods
    include Guidecase::DSL::DiagnosisMethods
    include Guidecase::DSL::QuestionMethods    
    include Guidecase::DSL::AnswerMethods
    include Guidecase::DSL::ComplaintMethods
        
    def self.included(base)
      base.instance_eval do
        def self.evaluate(text)
          dsl = new
          dsl.instance_eval(text)
          dsl
        end
      end
    end
    
    def define(key, &block)
      self.receiver = self
      self.slug = key # todo: fix dep
      yield self if block_given?
    end
    
    def parsing_group?; receiver.is_a? ::Group; end # todo: fix dep
    def parsing_question?; receiver.is_a? ::Question; end # todo: fix dep
    def parsing_answer?; receiver.is_a? ::Answer; end # todo: fix dep
    def parsing_outcome?; receiver.is_a? ::Outcome; end # todo: fix dep
    def parsing_diagnosis?; receiver.is_a? ::Diagnosis; end # todo: fix dep
    def parsing_complaint?; receiver.is_a? ::Complaint; end # todo: fix dep    
    
    def version_number(version)
      self.version = version
    end

    def description(text)
      if parsing_diagnosis?; diagnosis_description(text)
      else; self.summary = text.to_s
      end
    end
    
    def warning(key, description=nil)
      question_warning(key, description) if parsing_question?
    end
    
    def given(*args)
      condition = Condition.new
      condition._id = receiver.conditions.size
      args.each { |arg| condition.answers << arg }
      receiver.conditions << condition
    end

    def group(key, &block)
      group = Group.new :_id => key
      self.groups << group
      
      self.receiver = group
      yield self if block_given?
      self.receiver = self
    end
    
    def explanation(text)
      if parsing_answer?; answer_explanation(text)
      elsif parsing_complaint?; complaint_explanation(text)
      elsif parsing_question?; question_explanation(text)
      end
    end
    
    def illustration(path)
      receiver.send(:image=, path)
    end
  end
end