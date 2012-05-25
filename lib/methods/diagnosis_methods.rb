module Guidecase
  module DSL
    module DiagnosisMethods
      def new_diagnosis(params)
        ::Diagnosis.new params
      end

      def diagnose(key, &block)
        diagnosis = new_diagnosis(:_id => key)
        self.receiver.diagnoses << diagnosis
        self.receiver = diagnosis
        yield self if block_given?
        self.receiver = self
      end
      
      def symptom(key)
        self.receiver.symptoms << key
      end
      
      def disease(key)
        self.receiver.disease = key
      end
      
      def diagnosis_description(text)
        self.receiver.description = text
      end
      
      def low_risk
        self.receiver.low_risk = true
      end      
    end
  end
end