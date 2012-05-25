module Guidecase
  module DSL
    module AgreementMethods
      def agree(key, &block)
        self.agreement = Agreement.new :_id => key
        yield self if block_given?        
      end
    
      def confirm(txt)
        self.agreement.confirmations << txt
      end   
    end
  end
end