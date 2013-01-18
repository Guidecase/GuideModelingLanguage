require 'test_helper'

class GuideMethodsTest < Test::Unit::TestCase
  def setup
    @guide = Guide.new
  end
  
  def test_ignore_diagnoses_weighted_below
    assert_equal 3, @guide.weight_threshold
    
    @guide.ignore_diagnoses_weighted_below 10
    assert_equal 10, @guide.weight_threshold
  end
end