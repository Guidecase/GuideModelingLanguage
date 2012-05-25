module Guidecase
  module DSL
    module OutcomeMethods
      def new_outcome(params)
        ::Outcome.new params
      end
      
      def outcome(key, &block)
        urgency_level = self.outcomes.size + 1
        outcome = new_outcome :_id => key, :urgency => urgency_level
        self.outcomes << outcome
        
        self.receiver = outcome
        self.instance_eval(&block) if block_given?
        self.receiver = self
      end

      def summarize(title_or_text, text=nil)
        text = text ? text : title_or_text
        title = text ? title_or_text : nil
        summary = TitledText.to_mongo TitledText.new(text, title)
        receiver.summaries << summary
      end

      def warn(key)
        receiver.warning = key
      end
      
      def recommend(key)
        receiver.recommendation = key
      end
            
      def indicator(key)
        receiver.indicators << key
      end

      def header(key)
        receiver.headings << key
      end

      def paragraph(key)
        receiver.paragraphs << key
      end

      def tip(tip, conditions=[])
        receiver.tips << tip
      end     
      
      def sick_days(day_count)
        receiver.sick_days = day_count
      end       
    end
  end
end