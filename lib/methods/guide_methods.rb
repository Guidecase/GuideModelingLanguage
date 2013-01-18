module Guidecase
  module DSL
    module GuideMethods
      def ignore_diagnoses_weighted_below(weight=3)
        (receiver || self).weight_threshold = weight
      end
    end
  end
end