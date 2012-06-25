module Guidecase
  module DSL
    module AnatomyMethods
      def new_anatomy(params)
        ::Anatomy.new params
      end
      
      def body(key, explanation=nil, illustration=nil)
        self.anatomy = new_anatomy(:_id => key, :explanation => explanation, :image => illustration)
      end
    end
  end
end