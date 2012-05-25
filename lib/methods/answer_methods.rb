module Guidecase
  module DSL
    module AnswerMethods
      def new_answer(params)
        ::Answer.new params
      end
      
      def answer(key, &block)
        question = self.receiver
        answer = new_answer(:_id => key)
        question.answers << answer
        
        self.receiver = answer
        yield self if block_given?
        self.receiver = question
      end     
      
      def answer_explanation(text)
        receiver.explanation = text
      end
    end
  end
end