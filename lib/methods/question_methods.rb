module Guidecase
  module DSL
    module QuestionMethods
      def new_question(params)
        ::Question.new params
      end

      def question(key, reply_type=nil, &block)
        if block_given?
          question = new_question(:_id => key, :reply => reply_type)
          receiver.questions << question
          group = receiver
          self.receiver = question
          yield self if block_given?
          self.receiver = group
        else
          question = Guide.lookup_question(key)
          receiver.questions << question
        end
      end
      
      def required
        receiver.required = true
      end
                  
      def question_warning(key, description=nil)
        receiver.alerts << Alert.new(:_id => key, :description => description)
      end
      
      def question_explanation(text)
        receiver.explanation = text
      end
    end
  end
end