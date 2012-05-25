module Guidecase
  module DSL
    module ComplaintMethods
      def new_complaint(params)
        ::Complaint.new params
      end

      def complain(key, &block)
        complaint = new_complaint(:_id => key)
        self.receiver = complaint
        self.complaints << complaint
        yield self if block_given?
        self.receiver = self
      end
      
      def complaint_explanation(text)
        receiver.description = text
      end
    end
  end
end