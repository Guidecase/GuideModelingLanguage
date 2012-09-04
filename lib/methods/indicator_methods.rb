module Guidecase
  module DSL
    module IndicatorMethods
      def new_indicator(params)
        ::Indicator.new params
      end

      def indicator(key, &block)
        ind = new_indicator(:_id => key)
        self.receiver.indicators << ind
        r = self.receiver
        self.receiver = ind
        yield self if block_given?
        self.receiver = r
      end
    end
  end
end