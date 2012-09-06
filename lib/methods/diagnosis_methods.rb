module Guidecase
  module DSL
    module DiagnosisMethods
      def new_diagnosis(params)
        ::Diagnosis.new params
      end

      def diagnose(key, common_name_or_weight=nil, weight=nil, &block)
        common_name = common_name_or_weight.is_a?(String) ? common_name_or_weight : key
        weight = if common_name_or_weight && (Float(common_name_or_weight) != nil rescue false)
          Float(common_name_or_weight) 
        else 
          weight
        end

        diagnosis = new_diagnosis(:_id => key, :name => common_name, :weight => weight)
        self.receiver.diagnoses << diagnosis
        self.receiver = diagnosis
        yield self if block_given?
        self.receiver = self
      end
      
      def symptom(key, weight=1)
        s = Symptom.new(:weight => weight)
        s._id = key
        s.weight = weight
        self.receiver.symptoms << s
      end
      
      def disease(key)
        self.receiver.disease = key
      end
      
      def diagnosis_description(text)
        self.receiver.description = text
      end      
    end
  end
end