module Guidecase
  module DSL
    module DiagnosisMethods
      def new_diagnosis(params)
        ::Diagnosis.new params
      end

      def diagnose(key, common_name=nil, &block)
        diagnosis = new_diagnosis(:_id => key, :name => common_name || key)
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

      def risk(weight)
        self.receiver.weight = weight
      end       
    end
  end
end