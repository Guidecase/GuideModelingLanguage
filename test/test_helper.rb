require 'test/unit'
require '../lib/guide_modeling_language.rb'

class Guide
  include Guidecase::DSL

  attr_accessor :_id, :slug, :version, :summary, :agreement
  attr_accessor :groups, :diagnoses, :complaints, :outcomes

  def initialize
    @groups = []
    @diagnoses = []
    @complaints = []
    @outcomes = []
  end  
  
  def instance_test_method
    true
  end  
end